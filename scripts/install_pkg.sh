#!/bin/bash
set -euo pipefail

sudo pacman -S --needed - < ~/dotfiles/packages/pacman.txt
yay -S --needed --noconfirm $(cat ~/dotfiles/packages/aur.txt | grep -Ev "yay")

cat ~/dotfiles/packages/pipx.txt | while read -r package; do
    pipx install "${package%% *}"
done
