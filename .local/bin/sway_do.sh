#!/usr/bin/env zsh

# This script runs commands which are not mapped to any
# sway keys via $mod+d + description

# comma separated
OPTIONS='say hello,notify-send "HELLO THERE" "this is a message"
lock screen,systemctl suspend && swaylock
move workspaces,~/.local/bin/mv_workspaces.sh
toggle dark/light mode,~/.local/bin/toggle_scheme.sh
disable wifi,nmcli radio wifi off
enable wifi,nmcli radio wifi on'

SEL=$(echo $OPTIONS | cut -d , -f1 | sort -ui  | bemenu  -l 50 -p "DO:")
[[ $SEL == "" ]] && exit 1 # exit if nothing was selected
CMD=$(echo $OPTIONS | grep -E "^$SEL" | cut -d , -f2)
zsh -c "$CMD"
