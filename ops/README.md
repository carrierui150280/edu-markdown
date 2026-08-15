# edu-markdown maintenance

This folder is the lightweight maintenance layer for the public GitHub repo.

## What it does

- checks the GitHub repo state through the public API
- checks whether a GitHub Release exists
- checks local `git` sync and working tree state
- writes a human-readable report to `ops/latest-maintenance.md`
- appends a machine-readable line to `ops/history.jsonl`

## What it does not do

- it does not publish code
- it does not create issues
- it does not edit GitHub settings
- it does not post externally in your name

## Manual run

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\ops\run-maintenance.ps1
```

## Scheduled run

The intended setup is:

- once at Windows logon
- once every 3 days as a periodic check

That gives you a practical rhythm without pretending the machine is always online.
