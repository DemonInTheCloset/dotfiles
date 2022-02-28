#!/bin/sh

# Send Header
echo '{"version":1}'
echo '['
echo '[],'

# Start conky
exec conky -c "$HOME/.config/conky/i3status-conky.conf"
