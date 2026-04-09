#!/usr/bin/env bash
set -euo pipefail

SKILL_NAME="source-to-blog-publisher"
CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
TARGET_DIR="$CODEX_HOME/skills/$SKILL_NAME"
SCRIPT_PATH="${BASH_SOURCE[0]:-$0}"
SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/$SKILL_NAME"
REPO_OWNER="${REPO_OWNER:-JakeFn123}"
REPO_NAME="${REPO_NAME:-source-to-blog-publisher-skill}"
REPO_REF="${REPO_REF:-main}"

download_skill() {
  local tmp_dir archive_url extracted_dir
  tmp_dir="$(mktemp -d)"
  archive_url="https://github.com/${REPO_OWNER}/${REPO_NAME}/archive/refs/heads/${REPO_REF}.tar.gz"
  curl -fsSL "$archive_url" -o "$tmp_dir/repo.tar.gz"
  tar -xzf "$tmp_dir/repo.tar.gz" -C "$tmp_dir"
  extracted_dir="$tmp_dir/${REPO_NAME}-${REPO_REF}/${SKILL_NAME}"
  if [[ ! -d "$extracted_dir" ]]; then
    echo "Downloaded archive does not contain ${SKILL_NAME}" >&2
    rm -rf "$tmp_dir"
    exit 1
  fi
  echo "$extracted_dir"
}

if [[ -d "$SOURCE_DIR" ]]; then
  INSTALL_SOURCE="$SOURCE_DIR"
else
  INSTALL_SOURCE="$(download_skill)"
fi

mkdir -p "$CODEX_HOME/skills"
rm -rf "$TARGET_DIR"
cp -R "$INSTALL_SOURCE" "$TARGET_DIR"

echo "Installed $SKILL_NAME to:"
echo "  $TARGET_DIR"
