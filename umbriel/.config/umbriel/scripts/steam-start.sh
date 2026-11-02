#!/usr/bin/env bash
set -euo pipefail
steam_window_id=$(umbriel windows --json | jq -r '[.[] | select(.title == "Steam Big Picture Mode")][0].id // empty')
if [[ -n "$steam_window_id" ]]; then
    exec umbriel msg window-focus "$steam_window_id"
fi
exec steam -bigpicture -tenfoot -fulldesktopres
