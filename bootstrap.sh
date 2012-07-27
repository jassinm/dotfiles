DOTFILES=$(pwd)


function link_file {
    source="${DOTFILES}/$1"
    target="${HOME}/.${1}"

    if [ -e "${target}" ]; then
        cp -RH $target $target.bak
    fi
    ln -nfs ${source} ${target}
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
    #install inosecu
    git clone --recursive https://github.com/sorin-ionescu/oh-my-zsh.git ~/.oh-my-zsh
    for rcfile in ~/.oh-my-zsh/templates/z{shenv,shrc,login,logout}; do
          cp -f $rcfile ~/.$rcfile:t
    done
    # cd $DOTFILES/oh-my-zsh/
    # sh bootstrap.sh
    # link_file oh-my-zsh
fi

cd $DOTFILES

link_file weechat
link_file zshrc
###inputrc
link_file inputrc
##tmux
link_file tmux.conf
##teamocil
link_file teamocil
##irssi
#link_file irssi
##ipython
link_file ipython
##git
link_file gitignore
link_file gitconfig
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

link_file ctags

link_file pentadactylrc

link_file lbdbrc

link_file urlview

git submodule init
git submodule update
git submodule foreach git pull origin master

#sudo gem install teamocil
