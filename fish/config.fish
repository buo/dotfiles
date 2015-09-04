#!/usr/bin/env fish

set -x DOTROOT "$HOME/.dotfiles"

for file in (find $DOTROOT -maxdepth 2 -name "*.fish" -not -path "$DOTROOT/fish/*.fish")
  source $file
end
