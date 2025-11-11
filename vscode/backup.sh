##
cp  $HOME/Library/Application\ Support/Code/User/{keybindings.json,settings.json} .

# copy snippets folder
cp -r $HOME/Library/Application\ Support/Code/User/snippets .

# copy list of extensions that currently installed
code --list-extensions --show-versions >> extensions.txt

