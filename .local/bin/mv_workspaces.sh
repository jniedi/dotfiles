#!/usr/bin/env zsh

error() {
    printf "Error: $1\n" >&2; exit 1
}

EXCLUDE_WS="1"

TARGET_OUTPUT=$(swaymsg -t get_outputs | jq -r '.[].name' | grep -oE '^DP-[23]')

[ -z $TARGET_OUTPUT ] && error 'no monitor found'

# Get all workspace numbers
for ws in $(swaymsg -t get_workspaces | jq -r '.[].name'); do
    if [[ "$ws" != "$EXCLUDE_WS" ]]; then
        swaymsg workspace "$ws"
        swaymsg move workspace to output "$TARGET_OUTPUT"
    fi
done

