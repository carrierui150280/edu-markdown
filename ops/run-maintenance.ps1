Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$opsRoot = Join-Path $repoRoot "ops"
$reportPath = Join-Path $opsRoot "latest-maintenance.md"
$historyPath = Join-Path $opsRoot "history.jsonl"

$owner = "carrierui150280"
$repo = "edu-markdown"
$repoApiUrl = "https://api.github.com/repos/$owner/$repo"
$latestReleaseApiUrl = "https://api.github.com/repos/$owner/$repo/releases/latest"
$timestampUtc = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")

if (-not (Test-Path $opsRoot)) {
    New-Item -ItemType Directory -Path $opsRoot | Out-Null
}

function Invoke-Git {
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$Arguments,
        [switch]$IgnoreFailure
    )

    $output = & git -C $repoRoot @Arguments 2>&1
    if ($LASTEXITCODE -ne 0 -and -not $IgnoreFailure) {
        throw "git $($Arguments -join ' ') failed: $output"
    }

    return ($output | Out-String).Trim()
}

function Invoke-GitHubApi {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Uri,
        [switch]$AllowNotFound
    )

    $headers = @{
        "User-Agent" = "edu-markdown-maintenance"
        "Accept" = "application/vnd.github+json"
    }

    try {
        return Invoke-RestMethod -Uri $Uri -Headers $headers -TimeoutSec 30
    } catch {
        if (
            $AllowNotFound -and
            $_.Exception.Response -and
            $_.Exception.Response.StatusCode.value__ -eq 404
        ) {
            return $null
        }

        throw
    }
}

$repoStatus = "ok"
$releaseStatus = "present"
$notes = New-Object System.Collections.Generic.List[string]

try {
    $repoInfo = Invoke-GitHubApi -Uri $repoApiUrl
} catch {
    $repoStatus = "github_api_failed"
    $repoInfo = $null
    $notes.Add("GitHub API check failed: $($_.Exception.Message)")
}

try {
    $releaseInfo = Invoke-GitHubApi -Uri $latestReleaseApiUrl -AllowNotFound
    if ($null -eq $releaseInfo) {
        $releaseStatus = "missing"
        $notes.Add("No GitHub Release exists yet for the pushed tag.")
    }
} catch {
    $releaseStatus = "release_api_failed"
    $releaseInfo = $null
    $notes.Add("Release API check failed: $($_.Exception.Message)")
}

try {
    Invoke-Git -Arguments @("fetch", "origin", "--prune") -IgnoreFailure | Out-Null
} catch {
    $notes.Add("git fetch failed: $($_.Exception.Message)")
}

$branch = Invoke-Git -Arguments @("rev-parse", "--abbrev-ref", "HEAD")
$headCommit = Invoke-Git -Arguments @("rev-parse", "HEAD")
$shortStatus = Invoke-Git -Arguments @("status", "--short", "--branch")
$statusLines = @($shortStatus -split "`r?`n" | Where-Object { $_ -ne "" })
$branchLine = if ($statusLines.Count -gt 0) { $statusLines[0] } else { "## $branch" }
$hasWorkingTreeChanges = $statusLines.Count -gt 1
$recentTags = Invoke-Git -Arguments @("tag", "--sort=-creatordate")
$latestTag = @($recentTags -split "`r?`n" | Where-Object { $_ -ne "" } | Select-Object -First 1)[0]

$starCount = if ($repoInfo) { [int]$repoInfo.stargazers_count } else { -1 }
$forkCount = if ($repoInfo) { [int]$repoInfo.forks_count } else { -1 }
$watcherCount = if ($repoInfo) { [int]$repoInfo.subscribers_count } else { -1 }
$openIssuesCount = if ($repoInfo) { [int]$repoInfo.open_issues_count } else { -1 }
$repoHtmlUrl = if ($repoInfo) { [string]$repoInfo.html_url } else { "https://github.com/$owner/$repo" }
$repoUpdatedAt = if ($repoInfo) { [string]$repoInfo.updated_at } else { "unknown" }
$repoPushedAt = if ($repoInfo) { [string]$repoInfo.pushed_at } else { "unknown" }
$latestReleaseName = if ($releaseInfo) { [string]$releaseInfo.name } else { "" }
$latestReleaseTag = if ($releaseInfo) { [string]$releaseInfo.tag_name } else { "" }
$latestReleasePublishedAt = if ($releaseInfo) { [string]$releaseInfo.published_at } else { "" }

if ($starCount -eq 0) {
    $notes.Add("Stars are still at 0. Priority remains packaging and distribution, not more features.")
}

if ($openIssuesCount -gt 0) {
    $notes.Add("There are open issues to review.")
}

if ($hasWorkingTreeChanges) {
    $notes.Add("Local working tree is not clean. Decide whether to commit or ignore those changes.")
}

$reportLines = @(
    "# edu-markdown maintenance report",
    "",
    "- Checked at (UTC): $timestampUtc",
    "- Repository: $repoHtmlUrl",
    "- Branch: $branch",
    "- HEAD: $headCommit",
    "- Branch status: $branchLine",
    "- Working tree clean: $(-not $hasWorkingTreeChanges)",
    "- Latest local tag: $latestTag",
    "- GitHub API status: $repoStatus",
    "- Release status: $releaseStatus",
    "- Stars: $starCount",
    "- Forks: $forkCount",
    "- Watchers: $watcherCount",
    "- Open issues: $openIssuesCount",
    "- Repo updated_at: $repoUpdatedAt",
    "- Repo pushed_at: $repoPushedAt"
)

if ($latestReleaseTag) {
    $reportLines += @(
        "- Latest GitHub release tag: $latestReleaseTag",
        "- Latest GitHub release name: $latestReleaseName",
        "- Latest GitHub release published_at: $latestReleasePublishedAt"
    )
}

$reportLines += @(
    "",
    "## Next actions",
    ""
)

if ($notes.Count -eq 0) {
    $reportLines += "- No immediate action needed."
} else {
    foreach ($note in $notes) {
        $reportLines += "- $note"
    }
}

$reportLines += @(
    "",
    "## Local status lines",
    ""
)

foreach ($line in $statusLines) {
    $reportLines += "- $line"
}

Set-Content -Path $reportPath -Value ($reportLines -join "`r`n") -Encoding UTF8

$historyEntry = [ordered]@{
    checked_at_utc = $timestampUtc
    repository = $repoHtmlUrl
    branch = $branch
    head = $headCommit
    branch_status = $branchLine
    working_tree_clean = (-not $hasWorkingTreeChanges)
    latest_local_tag = $latestTag
    github_api_status = $repoStatus
    release_status = $releaseStatus
    stars = $starCount
    forks = $forkCount
    watchers = $watcherCount
    open_issues = $openIssuesCount
    repo_updated_at = $repoUpdatedAt
    repo_pushed_at = $repoPushedAt
    latest_release_tag = $latestReleaseTag
    latest_release_name = $latestReleaseName
    latest_release_published_at = $latestReleasePublishedAt
    notes = @($notes)
}

Add-Content -Path $historyPath -Value (($historyEntry | ConvertTo-Json -Compress) + "`r`n") -Encoding UTF8

Write-Output "Wrote maintenance report to $reportPath"
