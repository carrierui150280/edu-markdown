# Examples

This folder is for realistic source materials and the Markdown generated from them.

## Layout

- `source/`
  - sample `txt`, `md`, `html`, `docx`, and `pdf` inputs
- `output/`
  - the generated Markdown files

## Regenerate

After installing dev dependencies:

```powershell
.\.venv\Scripts\python.exe .\scripts\generate_examples.py
```

That script rebuilds both `examples/source` and `examples/output`.
