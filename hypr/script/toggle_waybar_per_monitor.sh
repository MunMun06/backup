#!/bin/zsh

set -euo pipefail

# Target monitor e.g. eDP-1 or HDMI-A-1
TARGET=$1

# Find the PID of the waybar process running on that monitor
PID=$(ps aux | grep "waybar -o $TARGET" | grep -v grep | awk '{print $2}')

if [[ -n "$PID" ]]; then
    kill -USR1 $PID
fi
