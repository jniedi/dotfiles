#!/usr/bin/env zsh


# Returns the domain from an url

if [[ $# -ne 1 ]]; then
    echo "usage: get_domain.sh URL"
    exit 1
fi

domain=$(echo $1 | cut -d '/' -f 3)
echo "'$domain'"
echo $domain | xclip -selection clipboard
