#!/usr/bin/env bash

# inpried by https://github.com/holman/dotfiles/blob/master/script/bootstrap

DOTFILES="$(pwd -P)"


info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

link_file () {
  local src=$1 dst=$2

  rm -rf "$dst"
  success "removed $dst"

  ln -fs "$1" "$2"
  success "linked $1 to $2"
}


link_file "$DOTFILES"/prezto $HOME/.zprezto

stow prezto_config

stow p10k

#stow alacritty
stow kitty
stow tmux
stow ranger
stow bat


stow nvim

link_file "$DOTFILES/inputrc" "$HOME/.inputrc"
link_file "$DOTFILES/ackrc" "$HOME/.ackrc"
#link_file "$DOTFILES/ctags" "$HOME/.ctags"

link_file "$DOTFILES"/gitconfig $HOME/.gitconfig
link_file "$DOTFILES"/gitignore $HOME/.gitignore

##vim
link_file "$DOTFILES/vim" "$HOME/.vim"
link_file "$DOTFILES/vim/vimrc" "$HOME/.vimrc"

# link_file "$DOTFILES/alacritty" "$HOME/.config/alacritty"

##emacs
stow doom
stow doom_config
#

stow ipython
#jupyter
link_file "$DOTFILES/jupyter" "$HOME/.jupyter"
