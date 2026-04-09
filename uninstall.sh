#!/usr/bin/env bash
set -euo pipefail

SKILL_NAME="source-to-blog-publisher"
CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
TARGET_DIR="$CODEX_HOME/skills/$SKILL_NAME"

if [[ -d "$TARGET_DIR" ]]; then
  rm -rf "$TARGET_DIR"
  echo "Removed $TARGET_DIR"
else
  echo "Skill not installed: $TARGET_DIR"
fi

