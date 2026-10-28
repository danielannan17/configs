#!/bin/sh
# BetterTouchTool generates a new BTTPresetUUID on every export, so it is pinned below.
set -eu

dir=$(cd "$(dirname "$0")" && pwd)
out="$dir/Default.bttpreset"
tmp=$(mktemp -t btt-export)
trap 'rm -f "$tmp"' EXIT

pgrep -xq BetterTouchTool || exit 0

osascript -e "tell application \"BetterTouchTool\" to export_preset \"Default\" outputPath \"$tmp\" compress false includeSettings true" >/dev/null

sed -E 's/("BTTPresetUUID" : ")[^"]*"/\1D0A1E1B5-0000-4000-8000-000000000000"/' "$tmp" > "$tmp.pinned"
mv "$tmp.pinned" "$tmp"

[ -s "$tmp" ] || { echo "export produced no output" >&2; exit 1; }
cmp -s "$tmp" "$out" 2>/dev/null || cp "$tmp" "$out"
