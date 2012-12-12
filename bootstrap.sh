#!/usr/bin/env sh

DOTFILES="$(pwd)"

link_file () {
    source_="${DOTFILES}/$1"
    target_="${HOME}/.${1}"
    ln -nfs ${source_} ${target_}
}

excludes="README.rst\|Keymando\|aliases.zsh\|bootstrap.sh\|vim\|lein2\|zshrc"

for file_or_folder in `find . -maxdepth 1 -name '[!.]*' | sed "s|^\./||" | grep -v "$excludes"`
do
    link_file "$file_or_folder"
done

mkdir -p "$HOME"/.lein
ln -nfs "$DOTFILES"/lein2/project.clj "$HOME"/.lein/project.clj
