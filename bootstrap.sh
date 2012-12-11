DOTFILES=$(pwd)


function link_file {
    source="${DOTFILES}/$1"
    target="${HOME}/.${1}"

    ln -nfs ${source} ${target}
}

EXCLUDE="README.rst\|Keymando\|aliases.zsh\|bootstrap.sh\|vim\|lein2\|zshrc"

for i in `ls | grep -v $EXCLUDE`
do
    link_file $i
done

ln -nfs $DOTFILES/lein2/project.clj $HOME/.lein/project.clj

read -p "install vim' (y/n)?"
if [ "$REPLY" == "y" ]
then
    link_file vim
    ln -nfs $DOTFILES/vim/vimrc $HOME/.vimrc
fi
