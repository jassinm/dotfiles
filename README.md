# Installation

## Requirements

### Osx

```
brew install stow
```

### Debian

```
apt-get install zsh
apt-get install stow
```

## Install

```
git clone --recurse-submodules -j8 https://github.com/jassinm/dotfiles  ~/.dotfiles
sh bootstrap.sh
```

## Update

```
git pull
git submodule sync --recursive
git submodule update --init --recursive
```


# Setup

## Change shell

```
chsh -s /bin/zsh
```


## Doom emacs

install manually / TODO: why does stow not work
```
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
```

## Tmux

start tmux then run ~Control-a I~ to install the [[tpm][https://github.com/tmux-plugins/tpm]] plugins
