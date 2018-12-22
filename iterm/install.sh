#!/bin/sh

# See https://apple.stackexchange.com/a/167143
killall iTerm2
if [ -f "$HOME/Library/Preferences/com.googlecode.iterm2.plist" ]; then
    defaults delete "$HOME/Library/Preferences/com.googlecode.iterm2.plist"
fi
cp -f "$DOTROOT/iterm/com.googlecode.iterm2.plist" "$HOME/Library/Preferences/"
defaults read -app iTerm