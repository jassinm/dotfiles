#!/usr/bin/env bash


stow prezto
stow prezto_config

stow p10k

#stow alacritty
stow kitty
stow tmux

stow nvim

##emacs
stow doom
stow doom_config

stow input
stow ack
stow ranger
stow bat

stow git

##vim
#link_file "$DOTFILES/vim" "$HOME/.vim"
#link_file "$DOTFILES/vim/vimrc" "$HOME/.vimrc"

stow ipython
stow jupyter
