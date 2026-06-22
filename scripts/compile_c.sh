#!/bin/zsh

set -euo pipefail

cd "$1" || exit 1
gcc "$2" -o "$3"
