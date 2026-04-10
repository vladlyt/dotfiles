#!/bin/sh
# Toggles kitty between github-light and github-dark themes across all windows.

KITTY_CONF_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/kitty"
STATE_FILE="$KITTY_CONF_DIR/.current-theme"
LIGHT="$KITTY_CONF_DIR/themes/github-light.conf"
DARK="$KITTY_CONF_DIR/themes/github-dark.conf"

current=$(cat "$STATE_FILE" 2>/dev/null || echo "light")

if [ "$current" = "light" ]; then
    kitty @ set-colors --all --configured "$DARK"
    echo "dark" > "$STATE_FILE"
else
    kitty @ set-colors --all --configured "$LIGHT"
    echo "light" > "$STATE_FILE"
fi
