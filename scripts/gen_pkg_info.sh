#!/bin/bash
set -euo pipefail

PACKAGE_DIR=~/dotfiles/packages
PACKAGE_TOML="$PACKAGE_DIR/packages.toml"

pacman -Qqen > "$PACKAGE_DIR/pacman.txt"
pacman -Qqem > "$PACKAGE_DIR/aur.txt"

yay -Qqe | while IFS= read -r package; do
    grep -q "^$package" $PACKAGE_TOML || echo "$package" >> $PACKAGE_TOML
done

code --list-extensions > "$PACKAGE_DIR/vscode.txt"

pipx list --short > "$PACKAGE_DIR/pipx.txt"

systemctl list-units --type=service --state=running --no-legend | awk '{print $1}' > "$PACKAGE_DIR/services.txt"

for dir in ~/.config/vivaldi/Default/Extensions/*/; do
    id=$(basename "$dir")
    manifest=$(find "$dir" -name "manifest.json" | head -n1)
    name=$(grep -m1 '"name"' "$manifest" | sed -E 's/.*"name": *"([^"]+)".*/\1/')

    if [[ "$name" == __MSG_*__ ]]; then
        key=$(echo "$name" | sed -E 's/__MSG_(.*)__/\1/')
        default_locale=$(grep -m1 '"default_locale"' "$manifest" | sed -E 's/.*"default_locale": *"([^"]+)".*/\1/')
        msg_file=$(dirname "$manifest")/_locales/$default_locale/messages.json
        if [[ -f "$msg_file" ]]; then
            resolved=$(jq -r --arg k "$key" '.[$k].message // empty' "$msg_file")
            [[ -n "$resolved" ]] && name="$resolved"
        fi
    fi

    echo "$id — $name"
done > "$PACKAGE_DIR/vivaldi.txt"