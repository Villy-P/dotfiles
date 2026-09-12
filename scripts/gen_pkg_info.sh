#!/bin/bash
set -euo pipefail

PACKAGE_DIR=~/dotfiles/packages
PACKAGE_TOML="$PACKAGE_DIR/packages.toml"

rm_specific() {
    grep -vE "nvidia|ucode"
}

pacman -Qqen | rm_specific >"$PACKAGE_DIR/pacman.txt"
pacman -Qqem | rm_specific >"$PACKAGE_DIR/aur.txt"

yay -Qqe | rm_specific | while IFS= read -r package; do
    grep -q "^$package" $PACKAGE_TOML || echo "$package" >>$PACKAGE_TOML
done

pipx list --short >"$PACKAGE_DIR/pipx.txt"

systemctl list-units --type=service --state=running --no-legend | awk '{print $1}' >"$PACKAGE_DIR/services.txt"
