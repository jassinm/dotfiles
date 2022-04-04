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

#terminal
#link_file "$DOTFILES/alacritty.yml" "$HOME/.alacritty.yml"
#tmux
stow tmux

link_file "$DOTFILES"/prezto $HOME/.zprezto
for rcfile in `find "$DOTFILES/prezto_config/" -maxdepth 1 -type f ! -name ".DS_Store"`;
do
    basename_=`basename "$rcfile"`
    link_file "$rcfile" "$HOME"/."$basename_"
done


stow p10k

#stow alacritty
stow kitty

stow ranger


stow nvim
stow bat

link_file "$DOTFILES/inputrc" "$HOME/.inputrc"
link_file "$DOTFILES/ackrc" "$HOME/.ackrc"
#link_file "$DOTFILES/ctags" "$HOME/.ctags"

link_file "$DOTFILES"/gitconfig $HOME/.gitconfig
link_file "$DOTFILES"/gitignore $HOME/.gitignore

##vim
link_file "$DOTFILES/vim" "$HOME/.vim"
link_file "$DOTFILES/vim/vimrc" "$HOME/.vimrc"

#mkdir -p "$HOME/.config"
#link_file "$DOTFILES/vim"  "$HOME/.config/nvim"
#link_file "$DOTFILES/nvim" "$HOME/.config/nvim"
#link_file "$DOTFILES/bat" "$HOME/.config/bat"
#link_file "$DOTFILES/ranger" "$HOME/.config/ranger"

# link_file "$DOTFILES/alacritty" "$HOME/.config/alacritty"

##emacs
#link_file "$DOTFILES/doom.d" "$HOME/.doom.d"
stow doom.d
#

stow ipython
#jupyter
link_file "$DOTFILES/jupyter" "$HOME/.jupyter"
