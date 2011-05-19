#!/bin/zsh
tmux start-server

if ! $(tmux has-session -t 'Tmuxinator'); then
cd ~/code/rails_project
sudo /etc/rc.d/mysqld start
tmux new-session -d -s 'Tmuxinator' -n 'editor'
tmux set default-path ~/code/rails_project
tmux set-option base-index 1


tmux new-window -t 'Tmuxinator':2 -n 'shell'

tmux new-window -t 'Tmuxinator':3 -n 'database'

tmux new-window -t 'Tmuxinator':4 -n 'server'

tmux new-window -t 'Tmuxinator':5 -n 'logs'

tmux new-window -t 'Tmuxinator':6 -n 'console'

tmux new-window -t 'Tmuxinator':7 -n 'capistrano'

tmux new-window -t 'Tmuxinator':8 -n 'server'


# set up tabs and panes

# tab "editor"

tmux send-keys -t 'Tmuxinator':1 'rvm use 1.9.2@rails_project && vim' C-m

tmux splitw -t 'Tmuxinator':1
tmux send-keys -t 'Tmuxinator':1 'rvm use 1.9.2@rails_project && ' C-m

tmux splitw -t 'Tmuxinator':1
tmux send-keys -t 'Tmuxinator':1 'rvm use 1.9.2@rails_project && top' C-m

tmux select-layout -t 'Tmuxinator':1 'main-vertical'


# tab "shell"

tmux send-keys -t 'Tmuxinator':2 'rvm use 1.9.2@rails_project && git pull' C-m


# tab "database"

tmux send-keys -t 'Tmuxinator':3 'rvm use 1.9.2@rails_project && rails db' C-m


# tab "server"

tmux send-keys -t 'Tmuxinator':4 'rvm use 1.9.2@rails_project && rails s' C-m


# tab "logs"

tmux send-keys -t 'Tmuxinator':5 'rvm use 1.9.2@rails_project && tail -f logs/development.log' C-m


# tab "console"

tmux send-keys -t 'Tmuxinator':6 'rvm use 1.9.2@rails_project && rails c' C-m


# tab "capistrano"


# tab "server"

tmux send-keys -t 'Tmuxinator':8 'rvm use 1.9.2@rails_project && ssh me@myhost' C-m



tmux select-window -t 'Tmuxinator':1

fi

if [ -z $TMUX ]; then
    tmux -u attach-session -t 'Tmuxinator'
else
    tmux -u switch-client -t 'Tmuxinator'
fi
