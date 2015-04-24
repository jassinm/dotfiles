#!/usr/bin/env sh

DOTFILES="$(pwd)"

link_file () {
    source_="${DOTFILES}/$1"
    target_="${HOME}/.${1}"
    ln -nfs ${source_} ${target_}
}

excludes="bin\|iterm|Keymando\|lein2\|spacemacslayers\|vim\|prezto_config\|bootstrap.sh\|aliases.zsh\|README.org\|spacemacs"

for file_or_folder in `find . -maxdepth 1 -name '[!.]*' | sed "s|^\./||" | grep -v "$excludes"`;
do
    link_file "$file_or_folder"
done

mkdir -p "$HOME"/.lein
ln -nfs "$DOTFILES"/lein2/project.clj "$HOME"/.lein/project.clj

#vim
mkdir -p "$DOTFILES"/vim/tmp/undo
mkdir -p "$DOTFILES"/vim/tmp/backup
mkdir -p "$DOTFILES"/vim/tmp/swap
ln -nfs "$DOTFILES"/vim "$HOME"/.vim
ln -nfs "$DOTFILES"/vim/vimrc "$HOME"/.vimrc

#zsh


for rcfile in `find "$DOTFILES/prezto_config/"`;
do
    basename_=`basename "$rcfile"`
    ln -nfs "$rcfile" "$HOME"/."$basename_"
done

UNAME=$(uname -s)
if [ "$UNAME" = 'Darwin' ] ; then
    ln -nfs "$DOTFILES"/tmux.conf "$HOME"/.tmux.conf
else
    ln -nfs "$DOTFILES"/tmux_nonosx.conf "$HOME"/.tmux.conf
fi

touch $HOME/.profile

#emacs
ln -nfs "$DOTFILES"/spacemacslayers/loco $HOME/.emacs.d/private/loco
