# Publish Package

Copy-ready repository metadata for the first public push.

## Final repository name

- `edu-markdown`

## Final short description

- Convert teaching materials and web articles into clean Markdown with metadata.

## Alternate short descriptions

- Local-first material ingestion for education workflows.
- Turn mixed source materials into clean Markdown for AI pipelines.
- Normalize lesson materials into portable Markdown with metadata.

## Final one-paragraph description

- `edu-markdown` is a local-first CLI for turning mixed teaching materials such as web pages, HTML, TXT, Markdown, DOCX, and text-based PDFs into clean Markdown with YAML front matter. It is designed for teachers, content operators, and AI workflow builders who need readable, portable source material instead of raw document dumps.

## Final topics

- `markdown`
- `education`
- `document-conversion`
- `docx`
- `pdf`
- `cli`
- `knowledge-base`
- `llm`
- `content-processing`
- `python`

## Final About section

- Homepage: leave blank for now
- Topics: use the list above
- Social preview headline:
  - `Clean Markdown normalization for teaching materials`
- Social preview subtext:
  - `Convert URLs, DOCX, PDFs, and local notes into portable Markdown for search, chunking, and AI workflows.`

## Final first pinned screenshot or preview

- Use the generated examples in `examples/source` and `examples/output`
- First screenshot should show:
  - one mixed `source/` folder
  - one clean `output/` folder
  - one Markdown file open with YAML front matter visible

## Final public positioning

- Do not position it as a generic "better MarkItDown."
- Position it as:
  - "clean Markdown normalization for teaching materials"
  - or "local-first material ingestion for education workflows"
  - or "Markdown-first preprocessing for education and content teams"

## What to emphasize on first contact

- narrow problem, useful output
- local-first instead of cloud-heavy
- readable Markdown instead of raw extraction dumps
- metadata kept explicit for later indexing and audit
- useful for both educators and AI workflow builders

## Release title

- `v0.1.0`

## Push commands

```powershell
git remote add origin https://github.com/<your-account>/edu-markdown.git
git push -u origin main
git push origin v0.1.0
```

## Current local history

- `765f489` `Initial MVP release for edu-markdown`
- `f34aa61` `Prepare GitHub publish package`
