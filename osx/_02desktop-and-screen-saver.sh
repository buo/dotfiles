################################################################################
# Desktop & Screen Saver                                                       #
################################################################################

# Set Screen Savers
defaults -currentHost write com.apple.screensaver moduleDict "
  <dict>
    <key>moduleName</key><string>Shell</string>
    <key>path</key><string>/System/Library/Screen Savers/Shell.qtz</string>
    <key>type</key><integer>1</integer>
  </dict>
"

# Start after 30 Minutes
defaults -currentHost write com.apple.screensaver idleTime -int 1800

# Show with clock (default)
defaults -currentHost write com.apple.screensaver showClock -bool false
