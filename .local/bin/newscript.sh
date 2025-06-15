#!/usr/bin/env zsh

filename=$(gum input --placeholder 'name' --no-show-help)

while [ -f $filename ]; do
    printf "'$filename' exists!\n"
    filename=$(gum input --placeholder 'Enter other name' --no-show-help)
done


cat ~/.config/newscript.sh/$(gum choose zsh python) >> $filename
chmod +x $filename

echo "$(basename $0): created file '$filename'"
