# Make the focus automatically follow the mouse
defaults write com.apple.terminal FocusFollowsMouse -string true

# Only use UTF-8
defaults write com.apple.terminal StringEncodings -array 4

# Use Solarized Dark theme
# https://github.com/tomislav/osx-terminal.app-colors-solarized
open "$DIR/Solarized Dark.terminal"
defaults write com.apple.Terminal "Default Window Settings" -string "Solarized Dark"
defaults write com.apple.Terminal "Startup Window Settings" -string "Solarized Dark"
defaults import com.apple.Terminal "$HOME/Library/Preferences/com.apple.Terminal.plist"
