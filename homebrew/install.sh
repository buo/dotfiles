#!/bin/sh

# Ensure your Homebrew is up to date, and make sure your system is ready to brew.
brew update
brew doctor
brew upgrade

# Install homebrew packages
source $DOTROOT/homebrew/Brewfile

# Install homebrew cask packages
source $DOTROOT/homebrew/Caskfile
