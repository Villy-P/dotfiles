#!/bin/bash
set -euo pipefail

sudo pacman -S --needed - < ~/dotfiles/packages/pacman.txt
yay -S --needed --noconfirm $(cat ~/dotfiles/packages/aur.txt | grep -Ev "yay")

while read -r extension; do
    code --install-extension "$extension"
done < "~/dotfiles/packages/vscode.txt"