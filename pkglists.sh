#!/bin/sh

NATIVE=gen_pkg_native.txt
AUR=gen_pkg_aur.txt

# -Query Explicit Native  | remove version number
pacman -Qen | sed 's/ .*//' > "$NATIVE"
# -Query Explicit Foreign | remove version number
pacman -Qem | sed 's/ .*//' > "$AUR"
