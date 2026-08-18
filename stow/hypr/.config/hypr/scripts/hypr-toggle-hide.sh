#!/usr/bin/env bash

if hyprctl clients -j | jq -e '.[] | select(.workspace.name == "special:hidden")' >/dev/null; then
  hyprctl dispatch 'hl.dsp.workspace.toggle_special("hidden")'
else
  hyprctl clients -j | jq -r '.[].address' | while read -r addr; do
    hyprctl dispatch "hl.dsp.window.move({ workspace = 'special:hidden', window = 'address:$addr' })"
  done
fi