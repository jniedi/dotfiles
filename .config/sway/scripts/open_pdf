#!/usr/bin/env zsh


if [[ -z $1 ]]; then
    d=~/res
else
    d=$1
fi

f=$(cat <(fd -t l '.*' $d) <(fd -t f .pdf $d) | bemenu -il 50)
[[ ! -z $f ]] &&  zathura $f
