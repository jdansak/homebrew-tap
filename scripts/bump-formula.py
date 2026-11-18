#!/usr/bin/env python3
"""Update a Homebrew formula's version and SHA256 checksums from a GitHub release."""

import re
import sys
import urllib.error
import urllib.request
from pathlib import Path


def fetch_checksums(repo: str, tag: str) -> dict[str, str]:
    for candidate in ("checksums.txt", "SHA256SUMS.txt"):
        url = f"https://github.com/{repo}/releases/download/{tag}/{candidate}"
        try:
            with urllib.request.urlopen(url, timeout=30) as resp:
                text = resp.read().decode("utf-8")
            checksums: dict[str, str] = {}
            for line in text.splitlines():
                parts = line.strip().split()
                if len(parts) >= 2:
                    checksums[parts[-1].lstrip("./")] = parts[0]
            return checksums
        except urllib.error.HTTPError:
            continue
    raise SystemExit(f"Error: No checksums.txt or SHA256SUMS.txt found for {repo}@{tag}")


def update_formula(formula_path: Path, version: str, tag: str, checksums: dict[str, str]) -> None:
    content = formula_path.read_text()
    content = re.sub(
        r'^(\s*version\s+)"[^"]+"',
        rf'\1"{version}"',
        content,
        count=1,
        flags=re.MULTILINE,
    )

    lines = content.splitlines(keepends=True)
    updated: list[str] = []
    last_filename: str | None = None

    for line in lines:
        url_match = re.search(r'^(\s*url\s+)"([^"]+)"(.*)$', line)
        if url_match and not url_match.group(2).endswith(".git"):
            raw_url = url_match.group(2)
            new_url = re.sub(r"v\d+\.\d+\.\d+", tag, raw_url)
            new_url = re.sub(r"(?<![a-zA-Z0-9.])\d+\.\d+\.\d+(?![a-zA-Z0-9.])", version, new_url)
            resolved = new_url.replace("#{version}", version).replace("#{tag}", tag)
            last_filename = resolved.rsplit("/", 1)[-1]
            updated.append(f'{url_match.group(1)}"{new_url}"{url_match.group(3)}\n')
            continue

        sha_match = re.match(r'^(\s*sha256\s+)"[0-9a-fA-F]{64}"(.*)$', line)
        if sha_match and last_filename and last_filename in checksums:
            updated.append(f'{sha_match.group(1)}"{checksums[last_filename]}"{sha_match.group(2)}\n')
            last_filename = None
            continue

        updated.append(line)

    formula_path.write_text("".join(updated))
    print(f"Updated {formula_path} to version {version}")


def main() -> None:
    if len(sys.argv) != 4:
        raise SystemExit(f"Usage: {sys.argv[0]} <formula-name> <owner/repo> <tag>")

    formula_name, repo, tag = sys.argv[1:4]
    version = tag.removeprefix("v")
    formula_path = Path(__file__).resolve().parent.parent / "Formula" / f"{formula_name}.rb"

    if not formula_path.is_file():
        raise SystemExit(f"Error: Formula not found at {formula_path}")

    checksums = fetch_checksums(repo, tag)
    update_formula(formula_path, version, tag, checksums)


if __name__ == "__main__":
    main()
