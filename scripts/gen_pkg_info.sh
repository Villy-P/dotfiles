#!/bin/bash
PACKAGE_LIST=~/dotfiles/packages/packages.toml

pacman -Qqen > ~/dotfiles/packages/pacman.txt
pacman -Qqem > ~/dotfiles/packages/aur.txt

yay -Qqe | while IFS= read -r package; do
    grep -q "^$package" $PACKAGE_LIST || echo "$package" >> $PACKAGE_LIST
done