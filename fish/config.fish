#!/usr/bin/env fish

set -x DOTROOT "$HOME/.dotfiles"

for file in (find $DOTROOT -maxdepth 3 -name "*.fish" -not -path "$DOTROOT/fish/*.fish")
  source $file
end

# Append bin to the path list.
set PATH $PATH $DOTROOT/bin
