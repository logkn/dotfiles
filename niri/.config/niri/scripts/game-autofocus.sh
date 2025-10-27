#!/usr/bin/env bash
# Focus any newly opened window if Steam Big Picture currently has focus.

set -euo pipefail

gaming_ws_id=$(niri msg --json workspaces | jq -er '.[] | select(.name=="gaming") | .id') || {
    printf 'Unable to find workspace named "gaming"; exiting.\n' >&2
    exit 1
}

niri msg --json event-stream | while IFS= read -r line; do
    window_data=$(jq -er '
        if .WindowOpenedOrChanged.window then
            [
                .WindowOpenedOrChanged.window.id,
                (
                    .WindowOpenedOrChanged.window.workspace_id
                    // .WindowOpenedOrChanged.window.workspace.id
                )
            ] | @tsv
        elif .WorkspaceOpenedOrChanged.window then
            [
                .WorkspaceOpenedOrChanged.window.id,
                (
                    .WorkspaceOpenedOrChanged.window.workspace_id
                    // .WorkspaceOpenedOrChanged.window.workspace.id
                )
            ] | @tsv
        else
            error("no-window-payload")
        end
    ' <<<"$line" 2>/dev/null) || {
        continue
    }

    window_id=${window_data%%$'\t'*}
    window_workspace_id=${window_data#*$'\t'}

    if [[ "$window_workspace_id" != "$gaming_ws_id" ]]; then
        continue
    fi

    focused_info=$(niri msg --json focused-window 2>/dev/null) || {
        continue
    }
    focused_window_id=$(jq -er '.id' <<<"$focused_info" 2>/dev/null) || {
        continue
    }
    focused_workspace_id=$(jq -er '
        .workspace_id // .workspace.id
    ' <<<"$focused_info" 2>/dev/null) || {
        continue
    }

    if [[ "$focused_workspace_id" != "$gaming_ws_id" ]]; then
        continue
    fi
    if [[ "$window_id" == "$focused_window_id" ]]; then
        continue
    fi

    niri msg action focus-window --id "$window_id"
done
