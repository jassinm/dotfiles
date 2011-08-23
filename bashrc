source ~/.bash/aliases
source ~/.bash/completions
source ~/.bash/paths
source ~/.bash/config

# use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi

# The following three lines have been added by UDB DB2.
if [ -f /Users/locojay/sqllib/db2profile ]; then
    . /Users/locojay/sqllib/db2profile
fi


