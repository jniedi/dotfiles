#!/usr/bin/env zsh

# The idea of this script is to avoid having to go to workspace 1 (to the browser)
# type the query and go back to the current workspace
# TODO: checkout if there is another solution to achieve the same
# maybe you can use ddg bangs?



if [[ $1 == 'wikipedia' ]]; then
   query="$(cat /dev/null | bemenu --prompt 'wiki>')"
   [[ -z $query ]] && exit 1
    xdg-open "https://en.wikipedia.org/w/index.php?search=$query"
elif [[ $1 == 'scholar' ]]; then
   query="$(cat /dev/null | bemenu --prompt 'google scholar>' | tr ' ' '+')"
   [[ -z $query ]] && exit 1
   xdg-open "https://scholar.google.com/scholar?q=$query"
else 
   query="$(cat /dev/null | bemenu --prompt 'ddg>')"
   [[ -z $query ]] && exit 1
   xdg-open "https://html.duckduckgo.com/html?q=$query"
fi
