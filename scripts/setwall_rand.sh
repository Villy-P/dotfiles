#!/bin/bash

shopt -s nullglob

cd ~/pictures/wallpaper
files=( * )

if [ ${#files[@]} -gt 0 ]; then
    # Pick a random index based on array length
    wall="${files[RANDOM % ${#files[@]}]}"
    echo "Picking Wallpaper: $wall"
    ~/dotfiles/scripts/setwall.sh $wall
else
    echo "The directory is empty."
fi
