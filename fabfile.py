from fabric.api import local,lcd
import fabric

def updatesubmodules():
    local("git submodule foreach git checkout master")
    local("git submodule foreach git pull")

def _installdependencies():
    local("sudo gem install teamocil")
    local("mkdir -p $HOME/.ipython/")
def install():
    local("git submodule init")
    local("git submodule update")
    updatesubmodules()
    if fabric.contrib.console.confirm("install vim"):
        with lcd("./vim/"):
            local("fab install")
    if fabric.contrib.console.confirm("install oh-my-zsh"):
        with lcd("./oh-my-zsh/"):
            local("fab install")
    local("rake install")
