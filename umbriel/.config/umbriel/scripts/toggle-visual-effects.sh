#!/usr/bin/env bash
set -euo pipefail
umask 077

# The overlay includes the original config without editing it. Switching back
# reloads that config, including any changes made while effects were off.
config_path="${XDG_CONFIG_HOME:-${HOME}/.config}/umbriel/config.toml"
socket="${UMBRIEL_SOCKET:-${XDG_RUNTIME_DIR:?}/umbriel-${WAYLAND_DISPLAY:-wayland-0}.sock}"
# Scope state to this compositor instance, so a restart starts normally.
instance="$(stat -Lc '%i-%Z' "${socket}")"
state_dir="${XDG_RUNTIME_DIR:?}/umbriel-visual-effects-${instance}"
mkdir -p "${state_dir}"
exec 9>"${state_dir}/lock"
flock -x 9

override_path="${state_dir}/opaque.toml"
if [[ -f "${override_path}" ]]; then
    # Keep the marker if restoration fails, allowing the next press to retry.
    umbriel config-replace "${config_path}"
    rm -- "${override_path}"
    notify-send 'Transparency and blur restored' || true
else
    candidate="$(mktemp "${state_dir}/candidate.XXXXXX")"
    trap 'rm -f -- "${candidate}"' EXIT
    cat >"${candidate}" <<CONFIG
[include]
files = [$(jq -Rn --arg path "${config_path}" '$path')]

[appearance.blur]
enabled = false

[animation.windows_opacity]
enabled = false

[[window_rule]]
opacity = 1.0
blur = false
blur_popups = false

[[layer_rule]]
blur = false
blur_popups = false
CONFIG
    umbriel config validate -c "${candidate}"
    # Record the off-state before applying it: an interrupted command can
    # always be recovered by pressing the hotkey again.
    mv -- "${candidate}" "${override_path}"
    # Keep the marker on failure too: retrying restoration is safe even if
    # the IPC connection failed after the compositor applied the override.
    umbriel config-replace "${override_path}"
    notify-send 'Transparency and blur off' 'Press Mod+T to restore your normal appearance.' || true
fi
