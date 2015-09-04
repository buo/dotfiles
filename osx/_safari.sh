# Disable opening `safe` files automatically
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Allow hitting the backspace key to go to the previous page in history
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

# Enable the `Develop` menu and the `Web Inspector`
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true

# Set search type to `Contains` instead of `Starts With`
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Set home page to `about:blank`
defaults write com.apple.Safari HomePage -string "about:blank"

# Enable `Debug` menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Hide bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Add a context menu item for showing the `Web Inspector` in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
