# v0.1.0

First public MVP for `edu-markdown`.

## Highlights

- Convert URLs into article-style Markdown
- Convert local `txt`, `md`, `html`, `docx`, and text-based `pdf` files
- Convert whole directories with `convert-dir`
- Add YAML front matter for downstream AI or search workflows
- Ship example source files and generated output

## Good fit for

- teachers organizing lesson materials
- content teams building Markdown-first knowledge bases
- AI workflows that need normalized source text

## Current limitations

- OCR is not included yet
- PDF support depends on an extractable text layer
- formatting preservation is intentionally lightweight in v0.1.0

## Verification

- local test suite passing
- examples regenerated successfully
