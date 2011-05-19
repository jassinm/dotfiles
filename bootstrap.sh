git submodule init
git submodule update
cd ~/.dotfiles/vim
git submodule init
git submodule update
cd ~/.dotfiles/
rake install
ln -Fs ~/.dotfiles/vim/vimrc ~/.vimrc

