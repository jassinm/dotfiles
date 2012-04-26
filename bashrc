source ~/.bash/aliases
source ~/.bash/completions
source ~/.bash/paths
source ~/.bash/config
source .profile

# use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi

# The following three lines have been added by UDB DB2.
if [ -f /Users/locojay/sqllib/db2profile ]; then
    . /Users/locojay/sqllib/db2profile
fi



## START-BCVI
  echo $PATH | grep -q /Users/locojay/bin || PATH="/Users/locojay/bin/$PATH"
  test -n "$(which bcvi)" && eval "$(bcvi --unpack-term)"
  test -n "${BCVI_CONF}"  && alias vi="bcvi"
  test -n "${BCVI_CONF}"  && alias suvi="EDITOR='bcvi -c viwait' sudoedit"
  test -n "${BCVI_CONF}"  && alias bcp="bcvi -c scpd"
## END-BCVI

