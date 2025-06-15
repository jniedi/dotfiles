#!/usr/bin/env zsh


error() {
    echo "error: $1"
    exit 1
}

# WM_CLASS(STRING) = "instance", "class"
notify-send "WM_CLASS found" "$(xprop | grep -i 'WM_CLASS' | cut -d , -f 2)"
