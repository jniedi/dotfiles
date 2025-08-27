#!/usr/bin/env bash

DATA_FILE=~/.cache/bookmarks

[ ! -f $DATA_FILE ] && touch $DATA_FILE && echo ",https://www.theguardian.com/europe" >> $DATA_FILE

reg=$(cat $DATA_FILE | cut -d, -f1 | bemenu --list "100 down")
[[ -z $reg ]] && exit 1
xdg-open "$(grep "$reg" $DATA_FILE | cut -d, -f2)"
