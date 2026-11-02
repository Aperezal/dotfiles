#!/bin/bash
# Quake-style scratchpad toggle for Hyprland 0.55+ (Lua config).
#
# - If the scratchpad terminal exists: show/hide the special workspace.
# - If not: launch it, wait for it, make sure it lives in the special
#   workspace, then show it.
#
# Float / size / center for this class come from the "scratchpad-term"
# window rule in hyprland.lua; this script only guarantees the workspace.

APP_CLASS="scratchpad_term"
SPECIAL="scratch"
TERMINAL_CMD="kitty --class $APP_CLASS"
WAIT_TENTHS=40   # max wait for the window to appear (40 x 0.1s = 4s)

# Ignore key-repeat / double presses while a launch is in progress
exec 9>"${XDG_RUNTIME_DIR:-/tmp}/toggle_scratchpad.lock"
flock -n 9 || exit 0

# Dispatch a Lua dispatcher expression
dispatch() {
    hyprctl dispatch "$1" >/dev/null
}

# Exact class match (no accidental matches like "scratchpad_term2")
window_exists() {
    hyprctl clients | grep -Eq "^[[:space:]]*class: ${APP_CLASS}$"
}

# Prints the "workspace: ID (name)" line of the scratchpad window
window_workspace() {
    hyprctl clients | awk -v c="class: $APP_CLASS" '
        BEGIN { RS = ""; FS = "\n" }
        {
            found = 0; ws = ""
            for (i = 1; i <= NF; i++) {
                line = $i; sub(/^[ \t]+/, "", line)
                if (line == c) found = 1
                if (line ~ /^workspace:/) ws = line
            }
            if (found) { print ws; exit }
        }'
}

toggle_special() {
    dispatch "hl.dsp.workspace.toggle_special(\"$SPECIAL\")"
}

if window_exists; then
    toggle_special
    exit 0
fi

# --- Window does not exist: launch it ---
dispatch "hl.dsp.exec_cmd(\"$TERMINAL_CMD\")"

for _ in $(seq 1 "$WAIT_TENTHS"); do
    window_exists && break
    sleep 0.1
done

if ! window_exists; then
    command -v notify-send >/dev/null &&
        notify-send -u critical "Scratchpad" "Terminal did not start (class: $APP_CLASS)"
    exit 1
fi

# Safety net: if the window rule didn't place it in the special workspace
# (e.g. rule failed to load), move it there without following it.
case "$(window_workspace)" in
    *"special:$SPECIAL"*) ;;
    *) dispatch "hl.dsp.window.move({ workspace = \"special:$SPECIAL\", follow = false, window = \"class:^($APP_CLASS)\$\" })" ;;
esac

# Show it
toggle_special
