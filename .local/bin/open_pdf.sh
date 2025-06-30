#!/usr/bin/env zsh


# used by sway 

f=$(cat <(fd -t l '.*' ~/resources/books) <(fd -t f .pdf ~/resources/books) | bemenu -il 50)
[[ ! -z $f ]] &&  zathura $f
