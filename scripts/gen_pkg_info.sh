#!/bin/bash
set -euo pipefail

PACKAGE_DIR=~/dotfiles/packages
PACKAGE_TOML="$PACKAGE_DIR/packages.toml"

pacman -Qqen > "$PACKAGE_DIR/pacman.txt"
pacman -Qqem > "$PACKAGE_DIR/aur.txt"

yay -Qqe | while IFS= read -r package; do
    grep -q "^$package" $PACKAGE_TOML || echo "$package" >> $PACKAGE_TOML
done

pipx list --short > "$PACKAGE_DIR/pipx.txt"

systemctl list-units --type=service --state=running --no-legend | awk '{print $1}' > "$PACKAGE_DIR/services.txt"

