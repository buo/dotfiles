#!/bin/sh

if [ "$(uname -s)" == "Darwin" ]; then
  brew install fish

  # Add fish to standard shells
  echo "/usr/local/bin/fish" | sudo tee -a /etc/shells

  # Make fish your default shell
  chsh -s /usr/local/bin/fish
fi
