################################################################################
# Dock                                                                         #
################################################################################

# Set the icon size
defaults write com.apple.dock tilesize -int 55

# Dock magnification
defaults write com.apple.dock magnification -bool false

# Icon size of magnified Dock items
defaults write com.apple.dock largesize -int 64

# Position on screen: 'left', 'bottom', 'right'
#defaults write com.apple.dock orientation -string "bottom"

# Dock pinning: 'start', 'middle', 'end'
# defaults write com.apple.dock pinning -string 'middle'

# Minimize windows using: 'genie', 'scale', 'suck'
defaults write com.apple.dock mineffect -string "scale"

# Disable double-click a window's title bar to minimize
# defaults write NSGlobalDomain AppleMiniaturizeOnDoubleClick -bool true

# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Make Dock more transparent
defaults write com.apple.dock hide-mirror -bool true

# Reduce Dock clutter by minimizing windows into their application icons
defaults write com.apple.dock minimize-to-application -bool true

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Show indicators for open applications
defaults write com.apple.dock show-process-indicators -bool true

# Wipe all (default) app icons from the Dock
defaults write com.apple.dock persistent-apps -array ""

# Make icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true
