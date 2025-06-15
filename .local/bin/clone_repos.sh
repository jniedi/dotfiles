#!/usr/bin/env zsh

# This script clones all repos from https://github.com/luthen-real/* into
# ~/repos 
# for now it needs an explicit list

error() {
    echo "error: $1"
    exit 1
}

check_installed(){
    commands=(
        gum
    )
    for com in "$commands[@]"; do 
        if ! command $com --version &>/dev/null; then
            error "$com not installed"
            exit 1
        fi
    done
}

while read -r url; do
    mkdir -p ~/repos
    dir=$(basename $url | cut -d . -f1)
    git clone $url $REPOS/$dir
done < ~/.config/$(basename $0)/repos.txt
