#!/bin/sh

if [ "$(uname -s)" == "Darwin" ]; then
  if ! command -v fish >/dev/null 2>&1; then
    brew install fish
  fi

  # Add fish to standard shells
  if [ `grep "/usr/local/bin/fish" /etc/shells | wc -l` = "0" ]; then
    echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
  fi

  # Make fish your default shell
  me=`whoami`
  if [ `dscl . -read /Users/$me UserShell | grep "/usr/local/bin/fish" | wc -l` = "0" ]; then
    chsh -s /usr/local/bin/fish
  fi

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
