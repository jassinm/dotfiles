DOTFILES=$(pwd)

git submodule init
git submodule update
git submodule foreach git pull origin master

function link_file {
    source="${DOTFILEs}/$1"
    target="${HOME}/${1/_/.}"

    if [ -e "${target}" ]; then
        mv $target $target.bak
    fi

    ln -sf ${source} ${target}
}


read -p "install vim' (y/n)?"
if [ "$REPLY" == "y" ]
then
    cd $DOTFILES/vim
    sh bootstrap.sh
    link_file vim
fi
read -p "install oh-my-zsh' (y/n)?"
if [ "$REPLY" == "y" ]
then
    cd $DOTFILES/oh-my-zsh/
    sh bootstrap.sh
    link_file oh-my-zsh
fi

cd $DOTFILES


##inputrc
link_file inputrc
##tmux
link_file tmux
##teamocil
link_file teamocil
##irssi
link_file irssi
##ipython
link_file ipython
##git
link_file .gitignore
link_file .gitconfig
##ack
link_file ackrc
##bash
link_file bash
link_file bash_profile
link_file bashrc
##bin
link_file bin
##zlogin
link_file zslogin

##sudo gem install teamocil
