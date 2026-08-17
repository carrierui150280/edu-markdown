# OpenAI OSS Application Draft

Draft answers for a future `Codex for Open Source` application.

## Project URL

`https://github.com/carrierui150280/edu-markdown`

## Project name

`edu-markdown`

## Maintainer role / relationship to project

Primary maintainer and project creator.

## One-sentence project summary

`edu-markdown` is a local-first open source CLI that converts mixed teaching materials and source documents into clean Markdown with lightweight metadata for search, chunking, and AI workflows.

## What problem the project solves

Many real education and content workflows start with messy source material spread across URLs, copied notes, DOCX files, and PDFs. Those inputs are often usable by humans but not clean enough for downstream retrieval, annotation, chunking, or automation. `edu-markdown` focuses on the normalization layer: turning mixed source files into readable, portable Markdown with explicit provenance.

## Why this project is a good fit for OpenAI open source support

`edu-markdown` is a small open source CLI for turning mixed teaching materials and source documents into clean Markdown with lightweight metadata. The project focuses on a practical gap between raw document extraction and downstream AI workflows. It helps teachers, content operators, and AI workflow builders normalize URLs, HTML, TXT, Markdown, DOCX, and text-based PDFs into portable Markdown that is easier to search, chunk, review, and reuse.

The fit is strongest because the next stage of work is not generic product polish. It is directly adjacent to AI workflow quality:

- improving source normalization quality
- testing structured output for chunking and retrieval
- evaluating OCR fallback paths
- expanding realistic fixtures and regression checks

## Why this project matters

Many education and content workflows still begin with messy source material spread across different formats. Even when document converters exist, the output is often too noisy or too generic for real downstream use. `edu-markdown` keeps the scope narrow: produce readable Markdown with explicit provenance fields so the material is easier to index, audit, and process in later tools.

## Current project maturity

- public repository is live
- first public release: `v0.1.0`
- README, examples, tests, changelog, and release notes are already published
- supported inputs today:
  - URLs
  - local `html`, `txt`, `md`
  - `docx`
  - text-based `pdf`
  - recursive folder conversion

## Who the project serves

- teachers building reusable lesson-material archives
- content operators cleaning mixed source material
- AI workflow builders who need readable Markdown instead of raw extraction dumps

## How OpenAI credits would be used

The credits would be used to improve the open source project itself rather than for unrelated work. The most likely uses are:

- testing extraction and normalization quality across more real-world source files
- prototyping OCR fallback for image-only PDFs
- generating and evaluating chunked output formats for AI workflows
- improving metadata enrichment and source-structure handling
- building small open examples and regression checks for education-focused document pipelines

## Near-term roadmap if support is granted

- OCR fallback for image-only PDFs
- chunked JSON export for retrieval workflows
- richer front matter for subject, grade, and unit
- more examples and regression fixtures from realistic education material

## Why maintain this as open source

This project is more useful as open source than as a closed internal tool because the real value comes from broad edge-case exposure: strange PDFs, inconsistent handouts, exported web pages, and mixed-language teaching material. Open development makes it easier to collect fixtures, bug reports, and format-specific feedback from real users instead of guessing in isolation.

## Short application version

I am the creator and primary maintainer of `edu-markdown`, a local-first open source CLI for converting mixed teaching materials and source documents into clean Markdown with lightweight metadata. The project sits in a practical gap between raw document extraction and downstream AI workflows: it helps turn URLs, HTML, TXT, Markdown, DOCX, and text-based PDFs into readable, portable Markdown that is easier to search, chunk, review, and reuse.

The repository is already public with a first release (`v0.1.0`), tests, examples, and documentation. If granted OpenAI open source support, I would use the credits to improve normalization quality on more real-world files, prototype OCR fallback for image-only PDFs, evaluate chunked output formats for retrieval workflows, and expand open regression fixtures for education-focused document pipelines.
