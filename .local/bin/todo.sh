#!/usr/bin/env zsh


# append/list todos without opening a terminal
# the goal is to avoid procastinating via appending
# the thing I wanted to do to the list of todos 
# for later reference

# TODO: add functionality to check if run in terminal
function error(){
    printf "Error: $1\n"
    exit 1
}

TODOS=~/.cache/todos

# If the file doesn't exist, send notifcation and exit

[[ ! -f $TODOS ]] && error 'Todo file does not exist!'

if [[ $1 == 'append' ]]; then
    cat /dev/null | bemenu >> $TODOS
else # the default is listing the head of the file
   cat $TODOS | bemenu --list 15 
fi
