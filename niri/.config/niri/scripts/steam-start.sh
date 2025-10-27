# notify-send "Focusing on Gaming workspace..."
# niri msg action focus-workspace "gaming"

windows_output="$(niri msg windows)"
steam_window_id="$(awk '/^Window ID/ {id=$3; sub(":", "", id)} /^  Title: "Steam Big Picture Mode"/ {print id}' <<<"$windows_output")"

if [[ -n "$steam_window_id" ]]; then
    notify-send "Found Steam window (ID $steam_window_id), focusing..."
    niri msg action focus-window --id $steam_window_id
    exit 0
fi

# If we reach this point, the Steam window is not open.

notify-send "Starting Steam (Big Picture)..."
steam -bigpicture -tenfoot -fulldesktopres

# notify-send "Starting Steam (Big Picture)..."
# steam -tenfoot
