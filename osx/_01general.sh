################################################################################
# General                                                                      #
################################################################################

# Appearance For Buttons, Menus, and Windows
# Blue     : 1 (default)
# Graphite : 6
defaults write NSGlobalDomain AppleAquaColorVariant -int 1

# Use dark menu bar and Dock
#defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# Highlight color
# Red      : `1.000000 0.733333 0.721569`
# Orange   : `1.000000 0.874510 0.701961`
# Yellow   : `1.000000 0.937255 0.690196`
# Green    : `0.752941 0.964706 0.678431`
# Blue     : `0.847059 0.847059 0.862745` (default)
# Purple   : `0.968627 0.831373 1.000000`
# Pink     : `0.968627 0.831373 1.000000`
# Brown    : `0.929412 0.870588 0.792157`
# Graphite : `0.847059 0.847059 0.862745`
# Silver   : `0.776500 0.776500 0.776500` (custom)
defaults write NSGlobalDomain AppleHighlightColor -string '0.847059 0.847059 0.862745'

# Translucent menu bar - disabled in Yosemite
# defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

# Sidebar icon size
# Small  : 1
# Medium : 2 (default)
# Large  : 3
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

# Show scroll bars
# Automatically based on mouse or trackpad : `Automatic`
# When scrolling                           : `WhenScrolling`
# Always                                   : `Always`
defaults write NSGlobalDomain AppleShowScrollBars -string 'WhenScrolling'

# Close windows when quitting an application (default)
#defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

# Set number of recent items (Documents, Apps, and Servers)
# PlistBuddy approach appears broken:
# RecentApplications, RecentDocuments, RecentServers
#/usr/libexec/PlistBuddy -x -c "Set :RecentApplications:MaxAmount 0" ~/Library/Preferences/com.apple.recentitems.plist
for category in 'applications' 'documents' 'servers'; do
  /usr/bin/osascript -e "tell application \"System Events\" to tell appearance preferences to set recent $category limit to 0"
done
