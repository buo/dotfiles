#!/bin/bash

echo "==> afred"

__dirname="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
themes="$HOME/Library/Application Support/Alfred 3/Alfred.alfredpreferences/themes"

if [ ! -d "$themes" ]; then
  brew cask install alfred
  mkdir "$themes/deep-black"
  cp "$__dirname/theme.json" "$themes/deep-black/theme.json"
fi

echo "Done."
