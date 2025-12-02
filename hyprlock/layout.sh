#!/bin/zsh

layout=$(hyprctl devices -j | jq -r '.keyboards[0].active_keymap')

# fallback if nothing is detected
if [ -z "$layout" ]; then
    echo "??"
else
    echo "${layout:0:2}"  # Show first 2 letters: "en", "th"
fi

