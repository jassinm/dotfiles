#!/usr/bin/env sh

DOTFILES="$(pwd)"

#link_file () {
#    source_="${DOTFILES}/$1"
#    target_="${HOME}/.${1}"
#    ln -nfs ${source_} ${target_}
#}
#
#excludes="bin\|iterm\|Keymando\|lein2\|spacemacs_private\|vim\|prezto_config\|bootstrap.sh\|aliases.zsh\|README.org\|spacemacs\|prezto\|spacemacsrc"
#
#for file_or_folder in `find . -maxdepth 1 -name '[!.]*' | sed "s|^\./||" | grep -v "$excludes"`;
#do
#    echo "linking" $file_or_folder
#    link_file "$file_or_folder"
#done
#
#mkdir -p "$HOME"/.lein
#ln -nfs "$DOTFILES"/lein2/project.clj "$HOME"/.lein/project.clj

ln -fs "$DOTFILES"/ackrc $HOME/.ackrc
ln -fs "$DOTFILES"/ctags $HOME/.ctags
ln -fs "$DOTFILES"/gitconfig $HOME/.gitconfig
ln -fs "$DOTFILES"/gitignore $HOME/.gitignore
ln -fs "$DOTFILES"/inputrc $HOME/.inputrc
ln -fs "$DOTFILES"/lbdbrc $HOME/.lbdbrc
ln -fs "$DOTFILES"/teamocil $HOME/.teamocil
ln -fs "$DOTFILES"/weechat $HOME/.weechat
ln -fs "$DOTFILES"/urlview $HOME/.urlview
ln -fs "$DOTFILES"/ptpython $HOME/.ptpython

#vim
ln -nFs "$DOTFILES"/vim "$HOME"/.vim
ln -nfs "$DOTFILES"/vim/vimrc "$HOME"/.vimrc

mkdir -p .config
ln -nFs  "$DOTFILES"/vim  "$HOME"/.config/nvim

#zsh
touch $HOME/.profile

ln -nfs "$DOTFILES"/prezto $HOME/.zprezto

for rcfile in `find "$DOTFILES/prezto_config/"`;
do
    basename_=`basename "$rcfile"`
    ln -nfs "$rcfile" "$HOME"/."$basename_"
done

# tmux

UNAME=$(uname -s)
if [ "$UNAME" = 'Darwin' ] ; then
    ln -fs "$DOTFILES"/tmux/tmux.conf "$HOME"/.tmux.conf
else
    ln -fs "$DOTFILES"/tmux/tmux_nonosx.conf "$HOME"/.tmux.conf
fi

#emacs
ln -fs "$DOTFILES"/emacs_spacemacs "$HOME"/.emacs.d
ln -fs "$DOTFILES"/spacemacs/spacemacs "$HOME"/.spacemacs
ln -fs "$DOTFILES"/spacemacs/private/loco $HOME/.emacs.d/private/loco
ln -fs "$DOTFILES"/spacemacs/private/themes $HOME/.emacs.d/private/themes
