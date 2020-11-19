#!/bin/bash

# Install oh-my-zsh
if ! command -v zsh &> /dev/null; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "'oh-my-zsh' already installed."
fi

# https://stackoverflow.com/a/41553295
login_shell=$(dscl . -read ~/ UserShell | sed 's/UserShell: //')

# Change the default login shell to zsh
if [ "$login_shell" != "/bin/zsh" ]; then
  chsh -s /bin/zsh
else
  echo "The default login shell is already set to '/bin/zsh'."
fi

symlink "$DIR/zshrc.symlink" "$HOME/.zshrc"