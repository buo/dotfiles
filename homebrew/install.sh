#!/bin/bash

if test command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Install homebrew packages
# source $DOTROOT/homebrew/Brewfile

# Install homebrew cask packages
# source $DOTROOT/homebrew/Caskfile

brew cleanup