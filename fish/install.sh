#!/bin/sh

if [ "$(uname -s)" == "Darwin" ]; then
  brew install fish

  # Add fish to standard shells
  echo "/usr/local/bin/fish" | sudo tee -a /etc/shells

  # Make fish your default shell
  chsh -s /usr/local/bin/fish

  if ! [ -d "$HOME/.config" ]; then
    mkdir "$HOME/.config"
  fi

  if ! [ -d "$HOME/.config/fish" ]; then
    mkdir "$HOME/.config/fish"
  fi

  DIR="$(pwd)/$(dirname $0)"
  ln -sf "$DIR/config.fish" "$HOME/.config/fish/config.fish"
  ln -sf "$DIR/functions" "$HOME/.config/fish/functions"
fi
