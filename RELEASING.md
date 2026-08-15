# Releasing

## First publish checklist

1. Run tests.
2. Regenerate examples.
3. Review `README.md`, `CHANGELOG.md`, and `LICENSE`.
4. Confirm no virtualenv or local output directories are tracked.
5. Tag the release after the repository is pushed.

## Local verification commands

```powershell
.\.venv\Scripts\python.exe -m pytest
.\.venv\Scripts\python.exe .\scripts\generate_examples.py
```

## Suggested first tag

- `v0.1.0`
