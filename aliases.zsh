#git
alias gst='git status'
alias gba='git branch -a'
alias gcaa="git commit -a --amend -C HEAD"
alias gpl='git pull'
alias gpom='git push origin master'
#tmux
alias tls='tmux list-sessions'
alias ta='tmux attach -t'

alias clj='rlwrap -a dummy clj'
alias mongo='rlwrap -a dummy mongo'
alias erl='rlwrap -a dummy erl'

alias zs='source ~/.zshrc'
alias pyclean='find . -type f -name "*.py[co]" -delete'
alias mkproject='mkproject -t locodev'
alias cdp='cd $PROJECT_HOME'
alias top='htop'
alias ipynb="ipython notebook --ip='*' --pylab=inline"

alias ka9='killall -9'
alias k9='kill -9'

alias clang11++='clang++ -std=c++11 -stdlib=libc++'
alias R='/usr/local/bin/r'

alias v='NVIM_TUI_ENABLE_TRUE_COLOR=1 nvim'
alias vim='NVIM_TUI_ENABLE_TRUE_COLOR=1 nvim'

#kubernetes
alias k='kubectl'
alias kg='kubectl get'
alias kga='kubectl get all'
alias kl='kubectl logs'
alias ke='kubectl exec -it'

#docker
alias d='docker'
alias dc='docker-compose'
