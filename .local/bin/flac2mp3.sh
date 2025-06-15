#!/usr/bin/env zsh

[[ ! -d $1 ]] && exit 1 

find $1 -type f -iname "*.flac" | while read f; do
  out="${f%.flac}.mp3"
  ffmpeg -i "$f" -codec:a libmp3lame -qscale:a 2 "$out"
done

