from fabric.api import local,lcd
import fabric

def updatesubmodules():
    local("git submodule foreach git checkout master")
    local("git submodule foreach git pull")

def _installdependencies():
    local("sudo gem install teamocil")
    local("sudo pip install ipython")
    local("mkdir -p $HOME/.ipython/")

def _intalldependencieslinux():
    local("sudo apt-get install gem")
    local("sudo apt-get install ruby")
    local("sudo apt-get install ruby-dev")
    local("sudo apt-get install ruby-gems")
    local("sudo apt-get install rake")

def link_file(filetolink):
    currentdir = local('echo $PWD',capture =True)
    local("ln -s " + currentdir + "/" + filetolink
          +" $HOME/." + filetolink )

def install():
    local("git submodule init")
    local("git submodule update")
    ostype = local("uname -s", capture=True)
    if ostype == "Linux":
        _intalldependencieslinux()
    updatesubmodules()
    if fabric.contrib.console.confirm("install vim"):
        with lcd("./vim/"):
            local("fab install")
    if fabric.contrib.console.confirm("install oh-my-zsh"):
        with lcd("./oh-my-zsh/"):
            local("fab install")
    local("rake install")
    _installdependencies()
