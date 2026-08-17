# edu-markdown

`edu-markdown` is a local-first CLI for turning mixed teaching materials into clean Markdown that is ready for search, chunking, and AI workflows.

It solves one narrow but useful problem:

- collect messy source material
- normalize it into readable Markdown
- keep lightweight metadata attached
- make the output portable for downstream tooling

## Why this is useful

Teaching and content workflows often start with a mess:

- public web pages
- copied notes
- exported HTML
- DOCX handouts
- text-based PDFs

Most converters stop at raw extraction. `edu-markdown` tries to do the next useful thing: produce Markdown that is readable enough for humans and structured enough for later pipelines.

## What it does

- Convert a URL into article-style Markdown
- Convert local `html`, `txt`, and `md` files into normalized Markdown
- Convert local `docx` files into readable Markdown
- Convert text-based `pdf` files into readable Markdown
- Convert a whole directory in one pass
- Add YAML front matter so the output is ready for downstream tooling

## Who it is for

- teachers building reusable lesson material
- content operators cleaning source material for knowledge bases
- AI workflow builders who need structured Markdown instead of raw files

## Good fit

- building a lesson-material knowledge base
- preparing source text for RAG or chunking pipelines
- cleaning exported documents before annotation or review
- normalizing mixed folders into one Markdown-first archive

## Quick example

Input folder:

- `reading-handout.pdf`
- `lesson-plan.docx`
- `unit-notes.txt`
- `article.html`

One command:

```powershell
.\.venv\Scripts\edu-markdown.exe convert-dir ".\materials" -o ".\output" --recursive
```

Output folder:

- `reading-handout.md`
- `lesson-plan.md`
- `unit-notes.md`
- `article.md`

Each generated file keeps readable Markdown plus YAML front matter.

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

### Example output

```yaml
---
title: Reading Handout
source: C:\materials\reading-handout.pdf
source_type: pdf_file
fetched_at: 2026-08-15T12:00:00Z
---
```

```md
# Reading Handout

Underline one sentence that reveals the setting.

Circle one word that shows the narrator's tone.
```

If `-o` is omitted, the tool writes `<input-name>.md` next to the source file. For URLs, the default output name is derived from the page title or host.

## Why the metadata matters

Each output file keeps the original source attached:

- `title`
- `source`
- `source_type`
- `fetched_at`

That makes the Markdown easier to audit, reprocess, index, or trace back later.

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

## Project status

- Current release: `v0.1.0`
- Status: usable MVP
- Focus: clean local conversion before OCR, chunk export, or richer pipeline features

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

## Current boundaries

- PDF support currently assumes the PDF has an extractable text layer.
- OCR is not implemented yet.
- `docx` conversion currently favors clean paragraph extraction over rich formatting preservation.
- The tool is local-first and CLI-first for now.

## Dev

Run tests:

```powershell
.\.venv\Scripts\python.exe -m pytest
```
