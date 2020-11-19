#!/bin/sh

if [ -d "/Applications/iTerm.app" ]; then
  echo "iTerm.app already installed."
else
  brew cask instal iterm2
fi