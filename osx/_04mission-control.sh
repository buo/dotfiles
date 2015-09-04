################################################################################
# Mission Control                                                              #
################################################################################

# Speed up Mission Control animation
defaults write com.apple.dock expose-animation-duration -float 0.1

# Don't group windows by application
defaults write com.apple.dock expose-group-by-app -bool false

# Don't automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false
