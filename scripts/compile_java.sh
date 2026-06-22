#!/bin/zsh

set -euo pipefail

cd "$1" || exit 1
javac "$2"
