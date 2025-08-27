#!/usr/bin/env bash

DATA_FILE=~/.cache/password_bookmarks

if [[ ! -f $DATA_FILE ]]; then 
    notify-send "INFO" "Password bookmarks empty" 
    exit 1
fi

reg=$(cat $DATA_FILE | cut -d, -f1 | bemenu --list "100 down")

[[ -z $reg ]] && exit 1 # check if aborted

password_file=$(grep "$reg" $DATA_FILE | cut -d, -f3) 
pass -c "$password_file" && notify-send "Info" "Copied '$password_file' to clipboard"
xdg-open "$(grep "$reg" $DATA_FILE | cut -d, -f2)"
