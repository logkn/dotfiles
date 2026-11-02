#!/usr/bin/env bash

set -euo pipefail

# Capture an interactively selected region with Wayland-native tools.
# The default mode saves the image to disk and copies it to the clipboard.

readonly mode="${1:-save}"

readonly screenshot_dir="${HOME}/Pictures/Screenshots"
readonly timestamp="$(date '+%Y-%m-%d %H-%M-%S')"
readonly screenshot_path="${screenshot_dir}/Screenshot from ${timestamp}.png"

region="$(slurp)"

# Cancel quietly when the selection is dismissed.
if [[ -z "${region}" ]]; then
    exit 0
fi

case "${mode}" in
    clipboard)
        grim -g "${region}" - | wl-copy --type image/png
        notify-send "Screenshot copied" "Region copied to clipboard"
        ;;
    save)
        mkdir -p "${screenshot_dir}"
        grim -g "${region}" - | tee "${screenshot_path}" | wl-copy --type image/png
        notify-send "Screenshot saved" "${screenshot_path}"
        ;;
    *)
        printf 'Unsupported screenshot mode: %s\n' "${mode}" >&2
        exit 1
        ;;
esac
