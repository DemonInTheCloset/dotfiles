#!/bin/sh

logdir="$XDG_DATA_HOME"/dinit

# picom
/usr/bin/picom >>"$logdir"/picom.log &

# xwallpaper
/usr/bin/xwallpaper --zoom /usr/share/backgrounds/archlinux/awesome.png >>"$logdir"/xwallpaper.log &
