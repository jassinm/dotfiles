DOTFILES=$(pwd)


function link_file {
    source="${DOTFILES}/$1"
    target="${HOME}/.${1}"

    ln -nfs ${source} ${target}
}

EXCLUDE="README.rst\|Keymando\|aliases.zsh\|bootstrap.sh"

for i in `ls | grep -v $EXCLUDE`
do
    link_file $i
done

# read -p "install vim' (y/n)?"
# if [ "$REPLY" == "y" ]
# then
#     cd $DOTFILES/vim
#     sh bootstrap.sh
#     link_file vim
# fi
#ln -nfs $DOTFILES/lein2/project.clj $HOME/.lein/project.clj
