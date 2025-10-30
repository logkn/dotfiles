#!/usr/bin/env bash
set -euo pipefail

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

exec wtype "$char"
