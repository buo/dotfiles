#!/bin/bash

if [ -d "/Applications/Alfred 4.app" ]; then
  echo "Alfred 4.app already installed."
else
  brew cask instal alfred
fi