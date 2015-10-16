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

  if ! [ -e "$HOME/.config/fish/config.fish" ]; then
    ln -sf "$DOTROOT/fish/config.fish" "$HOME/.config/fish/config.fish"
  fi

  if ! [ -e "$HOME/.config/fish/completions" ]; then
    ln -sf "$DOTROOT/fish/completions" "$HOME/.config/fish/completions"
  fi

  if ! [ -e "$HOME/.config/fish/functions" ]; then
    ln -sf "$DOTROOT/fish/functions" "$HOME/.config/fish/functions"
  fi
fi
