#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needsndkey -M viins md-mode
bindkey -M viins "jj" vi-cmd-mode
setopt interactivecomments
#
source ~/.profile
source ~/.dotfiles/aliases.zsh
#
if [ -f `brew --prefix`/etc/autojump.sh ]; then
     . `brew --prefix`/etc/autojump.sh
fi
