git submodule init
git submodule update
cd $HOME/.dotfiles/vim
sh bootstrap.sh
cd $HOME/.dotfiles/oh-my-zsh/
sh bootstrap.sh
cd $HOME/.dotfiles/
sudo gem install teamocil
rake install
#ln -Fs ~/.dotfiles/vim/vimrc ~/.vimrc

