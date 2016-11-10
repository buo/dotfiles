#!/usr/bin/env fish

set -x DOTROOT "$HOME/.dotfiles"

for file in (find $DOTROOT -maxdepth 3 -name "*.fish" -not -path "$DOTROOT/fish/*.fish")
  source $file
end

# Prepend bin to the path list.
set PATH $DOTROOT/bin $PATH

# The GOPATH enviconment variable
set -x GOPATH "$HOME/Projects"
if [ -d $GOPATH/bin ]
	set PATH $GOPATH/bin $PATH
end
