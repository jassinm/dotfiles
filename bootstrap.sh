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

  local overwrite= backup= skip=
  local action=

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
  then

    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
    then

      local currentSrc="$(readlink $dst)"

      if [ "$currentSrc" == "$src" ]
      then

        skip=true;

      else

        user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac

      fi

    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      success "removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
      mv "$dst" "${dst}.backup"
      success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]
    then
      success "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
    success "linked $1 to $2"
  fi
}


local overwrite_all=true backup_all=true skip_all=false

#terminal
link_file "$DOTFILES/alacritty.yml" "$HOME/.alacritty.yml"
#tmux
UNAME=$(uname -s)
if [ "$UNAME" = 'Darwin' ] ; then
    link_file "$DOTFILES"/tmux/tmux.conf "$HOME"/.tmux.conf
else
    link_file "$DOTFILES"/tmux/tmux_nonosx.conf "$HOME"/.tmux.conf
fi

link_file "$DOTFILES"/prezto $HOME/.zprezto
##zsh
#touch $HOME/.profile
#

for rcfile in `find "$DOTFILES/prezto_config/"`;
do
    basename_=`basename "$rcfile"`
    link_file "$rcfile" "$HOME"/."$basename_"
done

link_file "$DOTFILES/inputrc" "$HOME/.inputrc"
link_file "$DOTFILES/ackrc" "$HOME/.ackrc"
#link_file "$DOTFILES/ctags" "$HOME/.ctags"

link_file "$DOTFILES"/gitconfig $HOME/.gitconfig
link_file "$DOTFILES"/gitignore $HOME/.gitignore

#ln -fs "$DOTFILES"/lbdbrc $HOME/.lbdbrc
link_file "$DOTFILES"/urlview $HOME/.urlview
#
#ln -nFs "$DOTFILES"/ptpython $HOME/.ptpython
#ln -nFs "$DOTFILES"/teamocil $HOME/.teamocil
#ln -nFs "$DOTFILES"/weechat $HOME/.weechat

##vim
link_file "$DOTFILES"/vim "$HOME"/.vim
link_file "$DOTFILES"/vim/vimrc "$HOME"/.vimrc

mkdir -p "$HOME"/.config
link_file "$DOTFILES"/vim  "$HOME"/.config/nvim

##emacs
link_file "$DOTFILES/doom.d" "$HOME/.doom.d"
#

#link_file "$DOTFILES/ipython" "$HOME/.ipython"
#
##emacs
##ln -nFs "$DOTFILES"/emacs_spacemacs "$HOME"/.emacs.d
#ln -fs "$DOTFILES"/spacemacs/spacemacs "$HOME"/.spacemacs
##ln -fs "$DOTFILES"/spacemacs/private/loco $HOME/.emacs.d/private/loco
##ln -fs "$DOTFILES"/spacemacs/private/themes $HOME/.emacs.d/private/themes
##ln -fs "$DOTFILES"/spacemacs/private/snippets/org-mode $HOME/.emacs.d/private/snippets/org-mode
#
##jupyter
#
#mkdir -p $HOME/.jupyter
#mkdir -p $HOME/.jupyter/custom
#ln -fs "$DOTFILES"/jupyter/jupyter_notebook_config.py  $HOME/.jupyter/jupyter_notebook_config.py
##ln  -nFs "$DOTFILES"/jupyter/nbconfig  $HOME/.jupyter/nbconfig
#ln  -fs "$DOTFILES"/jupyter/custom/custom.js $HOME/.jupyter/custom/custom.js
