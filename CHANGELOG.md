# Changelog

## 0.1.0 - 2026-08-15

Initial public-facing MVP.

### Added

- URL to Markdown conversion with YAML front matter
- Local `txt`, `md`, `html`, and `docx` conversion
- Text-based `pdf` conversion
- Recursive directory conversion via `convert-dir`
- Example source files plus generated example outputs
- Basic automated test coverage for core conversion paths

### Notes

- PDF support currently depends on an extractable text layer.
- OCR and chunk export are intentionally out of scope for this first release.
