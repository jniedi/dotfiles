#!/usr/bin/env zsh


i=0
total_minutes=0
log_file=~/.cache/study_logs.txt

function exit_abort() {
    echo
    gum log --structured  --time ansic --level error "Aborted round $((i+1))."
    # Only log the time if 
    (($total_minutes)) && echo $(date "+%d.%m"): $total_minutes >>| $log_file;
    exit 1
}

trap  'exit_abort' INT TERM 



mins=$(gum input --placeholder 'Enter min...')
timer.sh $mins "BREAK"
total_minutes=$((total_minutes+mins))

while gum confirm --no-show-help "Continue?"; do 
    mins=$(gum input --placeholder 'Enter min...')
    timer.sh $mins "BREAK"
    total_minutes=$((total_minutes+mins))
    i=$((i+1))
done

(($total_minutes)) && echo $(date "+%d.%m"): $total_minutes >>| $log_file;
