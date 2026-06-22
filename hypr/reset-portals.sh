#!/bin/zsh

set -euo pipefail

sleep 1
# Kill any stalled or blindly-started portal instances
killall xdg-desktop-portal-hyprland
killall xdg-desktop-portal-gtk
killall xdg-desktop-portal

# Force systemd to see the updated environment variables
/usr/lib/xdg-desktop-portal-hyprland &
sleep 2
/usr/lib/xdg-desktop-portal &
