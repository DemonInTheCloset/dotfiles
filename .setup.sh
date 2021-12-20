#!/usr/bin/sh

# Apply Config
chezmoi apply 2> /tmp/chezmoi.log

# Generate symlinks
ln -sf "$XDG_CONFIG_HOME"/zsh/.zshenv "$HOME"/.zshenv
ln -sf "$XDG_CONFIG_HOME"/X11/xresources "$HOME"/.Xresources

# Download nvim-packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
