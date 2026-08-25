#!/bin/bash

shopt -s nullglob

cd ~/pictures/wallpaper
files=( * )

if [ ${#files[@]} -gt 0 ]; then
    # Pick a random index based on array length
    wall="${files[RANDOM % ${#files[@]}]}"
    echo "Picking Wallpaper: $wall"
    awww img "$wall" --transition-type fade --transition-duration 1
    matugen image "$wall" --mode dark --source-color-index 0
else
    echo "The directory is empty."
fi
