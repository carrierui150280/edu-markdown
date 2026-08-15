from __future__ import annotations

import argparse
from pathlib import Path

from .converter import convert_directory, convert_source


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="edu-markdown",
        description="Convert teaching materials and web articles into Markdown.",
    )
    subparsers = parser.add_subparsers(dest="command", required=True)

    convert_parser = subparsers.add_parser(
        "convert",
        help="Convert a URL or local file into Markdown.",
    )
    convert_parser.add_argument("source", help="URL or local file path")
    convert_parser.add_argument(
        "-o",
        "--output",
        help="Output Markdown file path",
    )

    convert_dir_parser = subparsers.add_parser(
        "convert-dir",
        help="Convert a directory of supported files into Markdown.",
    )
    convert_dir_parser.add_argument("source_dir", help="Source directory path")
    convert_dir_parser.add_argument(
        "-o",
        "--output-dir",
        help="Directory where converted Markdown files should be written",
    )
    convert_dir_parser.add_argument(
        "--recursive",
        action="store_true",
        help="Walk nested directories recursively",
    )

    return parser


def main() -> int:
    parser = build_parser()
    args = parser.parse_args()

    if args.command == "convert":
        output_path = Path(args.output) if args.output else None
        result = convert_source(args.source, output_path=output_path)
        print(f"Wrote {result}")
        return 0

    if args.command == "convert-dir":
        output_dir = Path(args.output_dir) if args.output_dir else None
        results = convert_directory(
            args.source_dir,
            output_dir=output_dir,
            recursive=args.recursive,
        )
        for result in results:
            print(f"Wrote {result}")
        print(f"Converted {len(results)} file(s)")
        return 0

    parser.error(f"Unknown command: {args.command}")
    return 2


if __name__ == "__main__":
    raise SystemExit(main())
