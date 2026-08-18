#!/bin/bash
set -euo pipefail

cd ~/dotfiles/stow
shopt -s nullglob
echo "Stowing all directories in ~/dotfiles/stow..."
for dir in */; do
    pkg="${dir%/}"
    echo "Stowing $pkg..."
    stow -t ~ "$pkg"
done