#!/bin/bash
set -e

REPO="https://github.com/Hiptostee/dotconfig.git"
TARGET="$HOME/.config"

# Dirs managed by this repo -- these get overwritten
MANAGED=(cagent ghostty iterm2 nvim nx op zellij)

if [ -d "$TARGET/.git" ]; then
  echo "dotconfig already installed, pulling latest..."
  git -C "$TARGET" pull
  exit 0
fi

TMPDIR=$(mktemp -d)
echo "Cloning dotconfig..."
git clone "$REPO" "$TMPDIR/dotconfig"

mkdir -p "$TARGET"

for dir in "${MANAGED[@]}"; do
  if [ -d "$TMPDIR/dotconfig/$dir" ]; then
    echo "Installing $dir..."
    rm -rf "$TARGET/$dir"
    cp -r "$TMPDIR/dotconfig/$dir" "$TARGET/$dir"
  fi
done

# Copy root-level files (README, start.sh, etc.)
for file in "$TMPDIR/dotconfig"/*; do
  name=$(basename "$file")
  if [ -f "$file" ]; then
    cp "$file" "$TARGET/$name"
  fi
done

rm -rf "$TMPDIR"
echo "Done. Existing unrelated configs in ~/.config were left untouched."
