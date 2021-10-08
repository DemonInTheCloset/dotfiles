#!/bin/zsh

msgid="65162"

volume="$(pamixer --get-volume)"
muted="$(pamixer --get-mute)"
if [[ $volume == 0 || $muted == true ]]; then
    dunstify -a "changedVolume" -u low -i audio-volume-muted -r "$msgid" "Volume Muted"
else
    dunstify -a "changedVolume" -u low -i audio-volume-high -r "$msgid" \
        -h int:value:"$volume" "Volume: ${volume}%"
fi
