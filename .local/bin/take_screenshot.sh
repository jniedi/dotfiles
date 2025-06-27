#!/usr/bin/env zsh


grim -g "$(slurp)" - | swappy -f - -o ~/$(date +%H:%M:%S)_screenshot.png
