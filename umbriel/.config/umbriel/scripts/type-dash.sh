#!/usr/bin/env bash
set -euo pipefail

# Give the compositor a brief moment to release the triggering modifiers
# before we inject the Unicode character into the focused client.
readonly TYPE_DELAY_MS=40

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <en|em>" >&2
    exit 1
fi

case "$1" in
    en)
        char=$'\u2013' # en dash
        ;;
    em)
        char=$'\u2014' # em dash
        ;;
    *)
        echo "Unknown dash type: $1" >&2
        exit 1
        ;;
esac

exec wtype -s "$TYPE_DELAY_MS" "$char"
