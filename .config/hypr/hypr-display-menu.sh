#!/usr/bin/env bash
# Display projection menu for Hyprland 0.55+ (Lua config).
# 'hyprctl keyword monitor' no longer exists; monitors are now set at runtime
# with 'hyprctl eval' running a Lua hl.monitor({...}) call.
# Runtime changes last until the config reloads (e.g. saving hyprland.lua).

# Define your monitor names
INTERNAL="eDP-1"
EXTERNAL="HDMI-A-1"

# Apply a monitor spec, e.g.: mon '{ output = "eDP-1", mode = "preferred", position = "auto", scale = 1.25 }'
mon() {
    hyprctl eval "hl.monitor($1)"
}

# Menu options matching Windows options
OPTIONS="1. PC screen only\n2. Duplicate\n3. Extend\n4. Second screen only"

CHOICE=$(echo -e "$OPTIONS" | wofi --dmenu --prompt "Projecting Mode:" --width 300 --height 210)

case "$CHOICE" in
    "1. PC screen only")
        mon "{ output = \"$INTERNAL\", mode = \"preferred\", position = \"auto\", scale = 1.25 }"
        mon "{ output = \"$EXTERNAL\", disabled = true }"
        ;;
    "2. Duplicate")
        # True mirroring: both monitors share position 0x0; external mirrors internal.
        mon "{ output = \"$INTERNAL\", mode = \"preferred\", position = \"0x0\", scale = 1 }"
        mon "{ output = \"$EXTERNAL\", mode = \"preferred\", position = \"0x0\", scale = 1, mirror = \"$INTERNAL\" }"
        ;;
    "3. Extend")
        # 'auto-right' recalculates the layout after applying the 1.25 scaling.
        mon "{ output = \"$INTERNAL\", mode = \"preferred\", position = \"auto\", scale = 1.25 }"
        mon "{ output = \"$EXTERNAL\", mode = \"preferred\", position = \"auto-right\", scale = 1 }"
        ;;
    "4. Second screen only")
        mon "{ output = \"$INTERNAL\", disabled = true }"
        mon "{ output = \"$EXTERNAL\", mode = \"preferred\", position = \"auto\", scale = 1.25 }"
        ;;
esac
