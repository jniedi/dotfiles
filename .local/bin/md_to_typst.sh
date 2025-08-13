#!/usr/bin/env zsh

error(){
    printf "Error: $1\n"
    exit 1
}
:
trap "rm $TEMP" EXIT

exit 0
TEMP=$(mktemp)
cat $1 | tr '#' '=' > $TEMP


rm $TEMP
