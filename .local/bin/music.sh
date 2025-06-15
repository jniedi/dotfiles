#!/usr/bin/env zsh


export queuefile=~/music/queue
export tmpfile=$(mktemp)


enqueue(){
    selection=$(find ~/music -type d | fzf)
    if [[ -d $selection ]]; then
        echo $selection >> $queuefile
    fi

}

gethead(){
    next=$(head -n1 $queuefile)
    [[ -z $next ]] && return 1
    tail -n+2 $queuefile > $tmpfile
    cat $tmpfile > $queuefile
    print $next
}



# Main script

[[ ! -d ~/music ]] && {  echo "Install music first" ; exit 1 }



touch $queuefile
enqueue


# while gethead;  do
#     echo "continue?"
#     read 
#     enqueue
# done 
