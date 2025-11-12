#!/usr/bin/env -S uv run --script

# /// script
# dependencies = ["httpx"]
# ///

import argparse
import pathlib
import shutil
import filecmp
import subprocess
import tarfile
import tempfile
import zipfile

import httpx

DEFAULT_FONT_GLOB_PATTERN = "*.ttf"
DEFAULT_FONT_INSTALL_DIR = "~/.local/share/fonts"


def download_font(url: str, dest_dir_path: pathlib.Path) -> pathlib.Path:
    dest_file_path = dest_dir_path / pathlib.Path(url).name

    response = httpx.get(url, follow_redirects=True)
    response.raise_for_status()
    dest_file_path.write_bytes(response.content)

    return dest_file_path


def extract_font(archive_path: str, target_dir_path: pathlib.Path) -> None:
    target_dir_path.mkdir()

    if zipfile.is_zipfile(archive_path):
        with zipfile.ZipFile(archive_path) as zf:
            zf.extractall(target_dir_path)
    elif tarfile.is_tarfile(archive_path):
        with tarfile.open(archive_path) as tf:
            tf.extractall(target_dir_path)
    else:
        raise ValueError("Unhandled archive type")


def get_archive_base_name(path: pathlib.Path) -> str:
    name = path.name
    for ext in (".tar.xz", ".tar.gz", ".tar.bz2", ".tar", ".zip"):
        if name.endswith(ext):
            return name[: -len(ext)]
    return name


def normalize_glob_patterns(patterns: str | list[str]) -> list[str]:
    if isinstance(patterns, str):
        patterns = patterns.split()

    result = []
    for p in patterns:
        p = p.strip()
        if not p:
            continue
        result.append(p)
    return result


def copy_files(src_dir_path: pathlib.Path, dest_dir_path: pathlib.Path, patterns: str) -> tuple[int, int, int]:
    if not src_dir_path.is_dir():
        raise ValueError(f"{src_dir_path} is not a directory.")

    dest_dir_path.mkdir(parents=True, exist_ok=True)

    matched_files = set()
    for pattern in normalize_glob_patterns(patterns):
        for file in src_dir_path.glob(pattern):
            if file.is_file():
                matched_files.add(file)

    if not matched_files:
        print(f"No files found matching {patterns}")
        return (0, 0, 0)

    added = 0
    updated = 0
    skipped = 0

    for file in matched_files:
        if not file.is_file():
            continue

        target_path = dest_dir_path / file.name

        if not target_path.exists():
            shutil.copy2(file, target_path)
            added += 1
            continue

        if filecmp.cmp(file, target_path, shallow=False):
            skipped += 1
            continue

        shutil.copy2(file, target_path)
        updated += 1

    return (added, updated, skipped)


def refresh_font_cache(force: bool = False) -> None:
    args = ["fc-cache"]

    if force:
        args.append("-f")

    subprocess.run(args, check=True)


def print_tree(path: pathlib.Path, prefix: str = "", print_dir_name: bool = True) -> None:
    if not path.is_dir():
        raise ValueError(f"{path} is not a directory.")

    if print_dir_name:
        print(path.name)

    entries = sorted(path.iterdir(), key=lambda e: (not e.is_dir(), e.name.lower()))
    total_entries = len(entries)

    for index, entry in enumerate(entries):
        connector = "├── " if index < total_entries - 1 else "└── "
        print(prefix + connector + entry.name)

        if entry.is_dir():
            # Add indentation for children
            extension = "│   " if index < total_entries - 1 else "    "
            print_tree(entry, prefix + extension, print_dir_name=False)


def cmd_install(args: argparse.Namespace) -> None:
    with tempfile.TemporaryDirectory() as tmp_dir:
        tmp_dir_path = pathlib.Path(tmp_dir)
        archive_path = download_font(args.url, tmp_dir_path)

        target_dir_path = tmp_dir_path / get_archive_base_name(archive_path)
        extract_font(archive_path, target_dir_path)

        font_dir_path = pathlib.Path(args.dir).expanduser().resolve()
        added, updated, skipped = copy_files(target_dir_path, font_dir_path, args.pattern)

        changed = (added + updated) > 0

        if changed:
            refresh_font_cache(force=True)

        print(f"CHANGED={int(changed)} added={added} updated={updated} skipped={skipped}")


def cmd_tree(args: argparse.Namespace) -> None:
    with tempfile.TemporaryDirectory() as tmp_dir:
        tmp_dir_path = pathlib.Path(tmp_dir)
        archive_path = download_font(args.url, tmp_dir_path)

        target_dir_path = tmp_dir_path / archive_path.stem
        extract_font(archive_path, target_dir_path)

        print_tree(target_dir_path)


def main() -> None:
    parser = argparse.ArgumentParser(description="Manage user fonts")
    subparsers = parser.add_subparsers(dest="command", required=True)

    install_parser = subparsers.add_parser("install", help="download and install a font")
    install_parser.add_argument("url", help="URL to the font archive")
    install_parser.add_argument(
        "--pattern",
        default=DEFAULT_FONT_GLOB_PATTERN,
        help=f"glob pattern to select font files from an archive (default: {DEFAULT_FONT_GLOB_PATTERN})",
    )
    install_parser.add_argument(
        "--dir",
        default=DEFAULT_FONT_INSTALL_DIR,
        help=f"override the font install directory (default: {DEFAULT_FONT_INSTALL_DIR})",
    )
    install_parser.set_defaults(func=cmd_install)

    tree_parser = subparsers.add_parser("tree", help="list font files found in an archive online")
    tree_parser.add_argument("url", help="URL to the font archive")
    tree_parser.set_defaults(func=cmd_tree)

    args = parser.parse_args()
    args.func(args)


if __name__ == "__main__":
    main()
