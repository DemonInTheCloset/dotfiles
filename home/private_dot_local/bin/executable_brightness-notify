#!/bin/env sh

msgid="65163"

brightness="$(xbacklight -perceived -get)"

dunstify -a "changedBrightness" -u low -i brightnesssettings -r "$msgid" \
    -h int:value:"$brightness" "Brightness: ${brightness}%"
