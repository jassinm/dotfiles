#!/usr/bin/env bash

UNAME=$(uname -s)

# ZSH
stow prezto
if [ "$UNAME" = 'Darwin' ] ; then
    stow prezto_config
else
    stow prezto_config_linux
fi
stow prezto_contrib
stow p10k


#stow alacritty
stow kitty
stow tmux

stow nvim
# emacs
# stow doom
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
