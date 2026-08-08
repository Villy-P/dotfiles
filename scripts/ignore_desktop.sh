#!/bin/bash
set -euo pipefail

to_ignore=(
    "rofi"
    "bssh"
    "bvnc"
    "lstopo"
    "avahi-discover"
    "org.freedesktop.Xwayland"
)

mkdir -p ~/.local/share/applications

for app in "${to_ignore[@]}"; do
    echo "Ignoring $app"
    desktop_file="/usr/share/applications/${app}.desktop"
    local_desktop_file="$HOME/.local/share/applications/${app}.desktop"
    if [ -f "$desktop_file" ]; then
        cp "$desktop_file" ~/.local/share/applications/
        sed -i 's/^NoDisplay=false/NoDisplay=true/' "$local_desktop_file"
        echo "NoDisplay=true" >> "$local_desktop_file"
    fi
done