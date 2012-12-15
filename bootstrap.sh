#!/usr/bin/env sh

DOTFILES="$(pwd)"

link_file () {
    source_="${DOTFILES}/$1"
    target_="${HOME}/.${1}"
    ln -nfs ${source_} ${target_}
}

excludes="README.rst\|Keymando\|aliases.zsh\|bootstrap.sh\|vim\|lein2|\prezto"

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
ln -nfs "$DOTFILES"/vim $HOME/.vim
#
ln -nfs "$DOTFILES"/prezto $HOME/.zprezto

# for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
#       ln -nfs "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
# done
