#!/bin/bash

wall="$1"

awww img "$wall" --transition-type fade --transition-duration 1
matugen image "$wall" --mode dark --source-color-index 0 --type scheme-vibrant