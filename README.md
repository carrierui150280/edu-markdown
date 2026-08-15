# edu-markdown

`edu-markdown` turns teaching materials and web articles into clean Markdown with lightweight metadata.

The first release is intentionally narrow:

- Convert a URL into article-style Markdown
- Convert local `html`, `txt`, and `md` files into normalized Markdown
- Convert local `docx` files into readable Markdown
- Convert text-based `pdf` files into readable Markdown
- Convert a whole directory in one pass
- Add YAML front matter so the output is ready for search, chunking, or later AI pipelines

## Why this exists

Teachers and content operators constantly collect material from:

- public web pages
- copied notes
- exported HTML
- lesson docs that later need to become searchable text

Most tools either dump noisy HTML or aim at general-purpose document conversion.  
`edu-markdown` starts with the simpler problem: make source material readable, portable, and structured enough for downstream workflows.

## Install

```powershell
cd C:\Users\admin\.openclaw\workspace\projects\edu-markdown
python -m venv .venv
.\.venv\Scripts\python.exe -m pip install -e .[dev]
```

## Usage

### Convert a webpage

```powershell
.\.venv\Scripts\edu-markdown.exe convert "https://example.com/article" -o output\article.md
```

### Convert a local HTML file

```powershell
.\.venv\Scripts\edu-markdown.exe convert ".\samples\lesson.html" -o output\lesson.md
```

### Convert a plain text note

```powershell
.\.venv\Scripts\edu-markdown.exe convert ".\notes\week1.txt"
```

### Convert a Word document

```powershell
.\.venv\Scripts\edu-markdown.exe convert ".\materials\lesson-plan.docx"
```

### Convert a text-based PDF

```powershell
.\.venv\Scripts\edu-markdown.exe convert ".\materials\reading-handout.pdf"
```

### Convert a directory recursively

```powershell
.\.venv\Scripts\edu-markdown.exe convert-dir ".\materials" -o ".\output" --recursive
```

If `-o` is omitted, the tool writes `<input-name>.md` next to the source file.  
For URLs, the default output name is derived from the page title or host.

## Output shape

Generated files start with YAML front matter like this:

```yaml
---
title: Example Article
source: https://example.com/article
source_type: url
fetched_at: 2026-08-15T12:00:00Z
---
```

Then the cleaned Markdown body follows.

## Scope of v0

Currently supported well:

- `http` and `https` URLs
- local `.html`
- local `.txt`
- local `.md`
- local `.docx`
- local `.pdf` with an extractable text layer
- batch conversion for supported local files

Not yet supported:

- OCR from images
- chunk export

Those are sensible next steps, but not needed for a credible first release.

## Example workflow

1. Drop mixed teaching materials into one folder.
2. Run `convert-dir` once.
3. Feed the generated Markdown into search, chunking, annotation, or AI grading pipelines.

## Examples

- See [examples/README.md](C:/Users/admin/.openclaw/workspace/projects/edu-markdown/examples/README.md:1) for sample source files and generated output.
- Regenerate them with:

```powershell
.\.venv\Scripts\python.exe .\scripts\generate_examples.py
```

## Roadmap

- OCR fallback for image-only PDFs
- chunked JSON export
- front matter fields for subject / grade / unit
- plug-in converters for common education sources

## Dev

Run tests:

```powershell
.\.venv\Scripts\python.exe -m pytest
```
