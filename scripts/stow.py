#!/usr/bin/env pytho3
import argparse
import os
import platform
import re
import socket
import sys
from pathlib import Path

import tomllib

DOTFILES = Path(__file__).resolve().parent.parent
STOW_DIR = DOTFILES / "stow"
OS = {"win32": "windows", "darwin": "macos"}.get(sys.platform, "linux")


def profiles(explicit: str | None) -> list[str]:
    names = [
        explicit or os.environ.get("DOTFILES_HOST", ""),
        socket.gethostname().split(".")[0],
    ]
    try:
        rel = platform.freedesktop_os_release()
        names += [rel.get("ID", ""), rel.get("NAME", "")]
    except OSError:
        pass
    names.append(OS)
    out = []
    for n in names:
        n = re.sub(r"\W", "", n).lower()
        if n and n not in out:
            out.append(n)
    return out


def expand(p: str) -> Path:
    return Path(os.path.expandvars(os.path.expanduser(p)))


def pick_target(entry: dict, names: list[str]) -> Path | None:
    for n in names:
        if n in entry:
            return expand(entry[n])
    return None


def plan(pkg: Path, names: list[str]):
    cfg_file = pkg / "stow.toml"
    if not cfg_file.exists():
        print(f"SKIP {pkg.name}: no stow.toml")
        return
    cfg = tomllib.loads(cfg_file.read_text())
    files = [f for f in pkg.rglob("*") if f.is_file() and f != cfg_file]
    for entry in cfg.get("targets", []):
        dst_root = pick_target(entry, names)
        if dst_root is None:
            continue
        for f in files:
            yield f, dst_root / f.relative_to(pkg)


def link(src: Path, dst: Path, dry: bool):
    if dst.is_symlink() and dst.resolve() == src.resolve():
        return
    if dst.exists() or dst.is_symlink():
        print(f"CONFLICT {dst}")
        return
    print(f"LINK {dst} -> {src}")
    if not dry:
        dst.parent.mkdir(parents=True, exist_ok=True)
        try:
            dst.symlink_to(src)
        except OSError as e:
            sys.exit(f"Symlink failed ({e}). On Windows, enable Developer Mode.")


if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("packages", nargs="*", help="default: all packages")
    ap.add_argument("--host", help="force a profile name")
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args()

    names = profiles(args.host)
    print(f"profiles: {', '.join(names)}")
    pkgs = args.packages or sorted(p.name for p in STOW_DIR.iterdir() if p.is_dir())
    for name in pkgs:
        for src, dst in plan(STOW_DIR / name, names):
            link(src, dst, args.dry_run)
