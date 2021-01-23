#!/bin/bash

########
# nvim #
########

mkdir -p "$XDG_DATA_HOME/nvim"
mkdir -p "$XDG_DATA_HOME/nvim/undo"

ln -sf "$DOTFILES/nvim/init.vim" "$XDG_DATA_HOME/nvim"

rm -rf "$XDG_DATA_HOME/X11"
ln -s "$DOTFILES/X11" "$XDG_DATA_HOME"

######
# i3 #
######

rm -rf "$XDG_DATA_HOME/i3"
ln -s "$DOTFILES/i3" "$XDG_DATA_HOME"

#######
# Zsh #
#######

mkdir -p "$XDG_DATA_HOME/zsh"
ln -sf "$DOTFILES/zsh/.zshenv" "$HOME"
ln -sf "$DOTFILES/zsh/.zshrc" "$XDG_DATA_HOME/zsh"
ln -sf "$DOTFILES/zsh/aliases" "$XDG_DATA_HOME/zsh/aliases"
rm -rf "$XDG_DATA_HOME/zsh/external"
ln -sf "$DOTFILES/zsh/external" "$XDG_DATA_HOME/zsh"

#########
# Fonts #
#########

cp -rf "$DOTFILES/fonts" "$XDG_DATA_HOME"

#########
# dunst #
#########

mkdir -p "$XDG_CONFIG_HOME/dunst"
ln -sf "$DOTFILES/dunst/dunstrc" "$XDG_CONFIG_HOME/dunst/dunstrc"