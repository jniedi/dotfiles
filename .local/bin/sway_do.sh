#!/usr/bin/env zsh

# comma separated
OPTIONS='
say hello,notify-send "HELLO THERE" "this is a message"
lock screen,systemctl suspend && swaylock
move workspaces,~/.local/bin/mv_workspaces.sh
'

SEL=$(echo $OPTIONS | cut -d , -f1 | sort -ui  | bemenu -p "DO: ")
[[ $SEL == "" ]] && exit 1 # exit if nothing was selected
CMD=$(echo $OPTIONS | grep -E "^$SEL" | cut -d , -f2)
zsh -c "$CMD"
