#!/usr/bin/env zsh


f=$(cat <(fd -t l '.*' ~/resources/books) <(fd -t f .pdf ~/resources/books) | bemenu -il 50)
[[ ! -z $f ]] &&  xdg-open $f
