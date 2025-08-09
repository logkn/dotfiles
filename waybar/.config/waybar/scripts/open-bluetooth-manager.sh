#!/usr/bin/env bash
set -euo pipefail

# Launch a command either via Hyprland or in background
hypr_exec=false
if command -v hyprctl >/dev/null 2>&1; then
  hypr_exec=true
fi

launch_line() {
  if $hypr_exec; then
    hyprctl dispatch exec "$*" >/dev/null 2>&1 &
  else
    nohup bash -lc "$*" >/dev/null 2>&1 &
  fi
  exit 0
}

# Prefer common GUI managers
if command -v blueman-manager >/dev/null 2>&1; then
  launch_line "$(command -v blueman-manager)"
fi

if command -v blueberry >/dev/null 2>&1; then
  launch_line "$(command -v blueberry)"
fi

if command -v gnome-control-center >/dev/null 2>&1; then
  launch_line "$(command -v gnome-control-center) bluetooth"
fi

# KDE System Settings modules (if available)
if command -v systemsettings6 >/dev/null 2>&1; then
  launch_line "$(command -v systemsettings6) kcm_bluetooth"
fi
if command -v systemsettings5 >/dev/null 2>&1; then
  launch_line "$(command -v systemsettings5) kcm_bluetooth"
fi

# Rofi-based bluetooth menu if available
if command -v rofi-bluetooth >/dev/null 2>&1; then
  launch_line "$(command -v rofi-bluetooth)"
fi

# TUI fallback: bluetuith in an available terminal
terminal_cmd="${TERMINAL:-}"
if [[ -z "${terminal_cmd}" ]]; then
  for t in alacritty kitty footclient foot wezterm ghostty gnome-terminal konsole xterm; do
    if command -v "$t" >/dev/null 2>&1; then
      terminal_cmd="$(command -v "$t")"
      break
    fi
  done
else
  if command -v "$terminal_cmd" >/dev/null 2>&1; then
    terminal_cmd="$(command -v "$terminal_cmd")"
  fi
fi

if command -v bluetuith >/dev/null 2>&1 && [[ -n "${terminal_cmd}" ]]; then
  case "$terminal_cmd" in
    */footclient)
      launch_line "$terminal_cmd bluetuith"
      ;;
    */foot)
      launch_line "$terminal_cmd bluetuith"
      ;;
    */kitty)
      launch_line "$terminal_cmd -e bluetuith"
      ;;
    */alacritty)
      launch_line "$terminal_cmd -e bluetuith"
      ;;
    */wezterm)
      launch_line "$terminal_cmd start -- bluetuith"
      ;;
    */ghostty)
      launch_line "$terminal_cmd -e bluetuith"
      ;;
    */konsole)
      launch_line "$terminal_cmd -e bluetuith"
      ;;
    */gnome-terminal)
      launch_line "$terminal_cmd -- bluetuith"
      ;;
    *)
      launch_line "$terminal_cmd -e bluetuith"
      ;;
  esac
fi

# Fallback: open bluetoothctl in a terminal if possible
if [[ -n "${terminal_cmd}" ]] && command -v bluetoothctl >/dev/null 2>&1; then
  btctl="$(command -v bluetoothctl)"
  case "$terminal_cmd" in
    */footclient|*/foot)
      launch_line "$terminal_cmd $btctl"
      ;;
    */kitty|*/alacritty|*/ghostty|*/konsole)
      launch_line "$terminal_cmd -e $btctl"
      ;;
    */wezterm)
      launch_line "$terminal_cmd start -- $btctl"
      ;;
    */gnome-terminal)
      launch_line "$terminal_cmd -- $btctl"
      ;;
    *)
      launch_line "$terminal_cmd -e $btctl"
      ;;
  esac
fi

# If we got here, we couldn't launch anything
if command -v notify-send >/dev/null 2>&1; then
  notify-send "Waybar Bluetooth" "No Bluetooth manager found. Install blueman/blueberry/rofi-bluetooth, or bluetuith; falling back to bluetoothctl requires a terminal in PATH."
fi

exit 0
