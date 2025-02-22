from __future__ import annotations

import argparse
import json
import os
import re
import subprocess
import sys
from typing import Literal

def get_latest_tag(repo: str, repo_url: str, version: str) -> str:
    if version == "develop":
        return "develop"
    regex = rf"v{version}.*"
    refs = subprocess.check_output(
        (
            "git",
            "-c",
            "versionsort.suffix=-",
            "ls-remote",
            "--refs",
            "--tags",
            "--sort=v:refname",
            str(repo_url),
            str(regex),
        ),
        encoding="UTF-8",
    ).split()[1::2]

    if not refs:
        raise RuntimeError(f'No tags found for version "{regex}"')
    ref = refs[-1]
    matches: list[str] = re.findall(regex, ref)
    if not matches:
        raise RuntimeError(f'Can\'t parse tag from ref "{ref}"')
    return matches[0]


def update_env(file_name: str, repo: str, tag: str | None = None):
    if not tag:
        return
    text = f"\n{re.sub(r"/[a-z0-9]/i", "_", repo).upper()}_VERSION={tag}"

    with open(file_name, "a") as f:
        f.write(text)

def _print_resp(repo: str, tag: str | None = None):
    print(json.dumps({repo: tag}))


def main(_args: list[str]) -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--repo", required=True)
    parser.add_argument("--repo_url", required=True)
    parser.add_argument("--version", required=True)
    args = parser.parse_args(_args)

    latest_tag = get_latest_tag(args.repo, args.repo_url, args.version)
    file_name = os.getenv("GITHUB_ENV")
    if file_name:
        update_env(file_name, args.repo, latest_tag)
    _print_resp(args.repo, latest_tag)
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
