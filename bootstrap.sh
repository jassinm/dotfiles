DOTFILES=$(pwd)
SYMLINK="ln -fs"

git submodule init
git submodule update

function link_file {
    source="${DOTFILEs}/$1"
    target="${HOME}/${1/_/.}"

    if [ -e "${target}" ]; then
        mv $target $target.bak
    fi

    ln -sf ${source} ${target}
}


link_file irssi
#read -p "install vim' (y/n)?"
#if [ "$REPLY" == "y" ]
#then
    #cd $DOTFILES/vim
    #sh bootstrap.sh
    #rm $HOME/.vim
    #$SYMLINK $DOTFILES/vim $HOME/.vim
#fi
#read -p "install oh-my-zsh' (y/n)?"
#if [ "$REPLY" == "y" ]
#then
    #cd $DOTFILES/oh-my-zsh/
    #sh bootstrap.sh
#fi

cd $DOTFILES


##inputrc
#$SYMLINK $DOTFILES/inputrc $HOME/.inputrc

##tmux
#$SYMLINK $DOTFILES/tmux.conf $HOME/.tmux.conf
##teamocil
#$SYMLINK $DOTFILES/teamocil $HOME/.teamocil

##irssi
#$SYMLINK $DOTFILES/irssi $HOME/.irssi

##ipython
#$SYMLINK $DOTFILES/ipython $HOME/.ipython


##git
#$SYMLINK $DOTFILES/gitignore $HOME/.gitignore
#$SYNLINK $DOTFILES/gitconfig $HOME/.gitconfig

##ack
#$SYMLINK $DOTFILES/ackrc $HOME/.ackrc

##bash
#$SYMLINK $DOTFILES/bash $HOME/.bash
#$SYMLINK $DOTFILES/bash_profile $HOME/.bash_profile
#$SYMLINK $DOTFILES/bashrc $HOME/.bashrc

##bin
#$SYMLINK $DOTFILES/bin $HOME/.bin

##zlogin
#$SYMLINK $DOTFILES/zlogin $HOME/.zlogin


##sudo gem install teamocil
