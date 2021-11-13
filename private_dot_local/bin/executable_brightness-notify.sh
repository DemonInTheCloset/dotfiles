#!/bin/env sh

msgid="65163"

brightness="$(xbacklight -perceived -get)"

dunstify -a "changedBrightness" -u low -i audio-volume-high -r "$msgid" \
    -h int:value:"$brightness" "Volume: ${brightness}%"
