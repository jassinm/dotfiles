f=$(pwd)
git submodule init
git submodule update
read -p "install vim' (y/n)?"
if [ "$REPLY" == "y" ]
then
	cd $HOME/.dotfiles/vim
	sh bootstrap.sh
fi
read -p "install oh-my-zsh' (y/n)?"
if [ "$REPLY" == "y" ]
then
	cd $HOME/.dotfiles/oh-my-zsh/
	sh bootstrap.sh
fi
cd $HOME/.dotfiles/
sudo gem install teamocil
rake install
mkdir -p $HOME/.ipython
