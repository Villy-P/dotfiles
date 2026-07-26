#!/bin/bash
PACKAGE_DIR=~/dotfiles/packages
PACKAGE_TOML="$PACKAGE_DIR/packages.toml"

pacman -Qqen > "$PACKAGE_DIR/pacman.txt"
pacman -Qqem > "$PACKAGE_DIR/aur.txt"

yay -Qqe | while IFS= read -r package; do
    grep -q "^$package" $PACKAGE_TOML || echo "$package" >> $PACKAGE_TOML
done