#!/bin/sh

logdir="$XDG_DATA_HOME"/dinit

# activitywatch
/usr/bin/aw-watcher-afk >>"$logdir"/aw-watcher-afk.log &
/usr/bin/aw-watcher-window >>"$logdir"/aw-watcher-window.log &
/usr/bin/aw-qt --autostart-modules none >>"$logdir"/aw-qt.log &

# audio
/usr/bin/pipewire >>"$logdir"/pipewire.log &
/usr/bin/wireplumber >>"$logdir"/wireplumber.log &
/usr/bin/pipewire-pulse >>"$logdir"/pipewire-pulse.log &

# blueman-applet
/usr/bin/blueman-applet >>"$logdir"/blueman-applet.log &

# dunst
/usr/bin/dunst -verbosity info --startup_notification true >>"$logdir"/dunst.log &

# mailnotify
/usr/bin/mbsync -V -a -c "$XDG_CONFIG_HOME"/isync/mbsyncrc >>"$logdir"/mbsync.log &
for file in "$XDG_CONFIG_HOME"/imapnotify/*.conf; do
	/usr/bin/goimapnotify -conf "$file" >>"$logdir/$(basename -s .conf "$file")".log &
done

# picom
/usr/bin/picom >>"$logdir"/picom.log &

# sxhkd
/usr/bin/sxhkd >>"$logdir"/sxhkd.log &

# xwallpaper
/usr/bin/xwallpaper --zoom /usr/share/backgrounds/archlinux/awesome.png >>"$logdir"/xwallpaper.log &
