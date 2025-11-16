autoload -Uz compinit
compinit
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# Customize to your needs...
setopt interactivecomments
bindkey -M viins "jk" vi-cmd-mode
#source $HOME/.aliases.zsh
#


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#source ~/.zsh-theme-gruvbox-material-dark
#eval "$(starship init zsh)"
#

# Move next only if `homebrew` is installed
if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
fi

if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

typeset -g POWERLEVEL9K_INSTANT_PROMPT=off


# Added by LM Studio CLI (lms)
export PATH="$PATH:$HOM/.lmstudio/bin"
# End of LM Studio CLI section
