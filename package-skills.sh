#!/usr/bin/env bash
# Package each skill as a .zip for upload to claude.ai
# (Settings → Capabilities → Skills → Upload skill).
#
# The zip must contain the skill directory itself, so that SKILL.md sits at
# <skill-name>/SKILL.md inside the archive.

set -euo pipefail

cd "$(dirname "$0")"
mkdir -p dist
rm -f dist/*.zip

for skill in skills/*/; do
  name="$(basename "$skill")"
  if [ ! -f "$skill/SKILL.md" ]; then
    echo "skip: $name has no SKILL.md" >&2
    continue
  fi
  (cd skills && zip -q -r "../dist/$name.zip" "$name" -x '*.DS_Store')
  echo "dist/$name.zip"
done
