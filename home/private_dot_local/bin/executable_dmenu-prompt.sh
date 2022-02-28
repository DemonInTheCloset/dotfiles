#!/bin/sh

[ "$(printf 'No\nYes\n' | dmenu -i -p """$1""")" = 'Yes' ] && eval "$2"
