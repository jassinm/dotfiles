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
ln -fs "$DOTFILES"/urlview $HOME/.urlview

ln -nFs "$DOTFILES"/ptpython $HOME/.ptpython
ln -nFs "$DOTFILES"/teamocil $HOME/.teamocil
ln -nFs "$DOTFILES"/weechat $HOME/.weechat

#vim
ln -nFs "$DOTFILES"/vim "$HOME"/.vim
ln -nfs "$DOTFILES"/vim/vimrc "$HOME"/.vimrc

mkdir -p .config
ln -nFs  "$DOTFILES"/vim  "$HOME"/.config/nvim

#zsh
touch $HOME/.profile

ln -nFs "$DOTFILES"/prezto $HOME/.zprezto

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
ln -nFs "$DOTFILES"/emacs_spacemacs "$HOME"/.emacs.d
ln -fs "$DOTFILES"/spacemacs/spacemacs "$HOME"/.spacemacs
ln -fs "$DOTFILES"/spacemacs/private/loco $HOME/.emacs.d/private/loco
ln -fs "$DOTFILES"/spacemacs/private/themes $HOME/.emacs.d/private/themes
ln -fs "$DOTFILES"/spacemacs/private/snippets/org-mode $HOME/.emacs.d/private/snippets/org-mode

#jupyter

mkdir -p $HOME/.jupyter
ln -fs "$DOTFILES"/jupyter/jupyter_notebook_config.py  $HOME/.jupyter/jupyter_notebook_config.py
ln  -nFs "$DOTFILES"/jupyter/nbconfig  $HOME/.jupyter/nbconfig
ln  -nFs "$DOTFILES"/jupyter/nbextensions /usr/local/share/jupyter/nbextensions
