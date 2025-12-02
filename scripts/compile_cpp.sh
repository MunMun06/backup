#!/bin/zsh

cd "$1" || exit 1
g++ "$2" -o "$3"
