# Disable guest user
defaults write com.apple.AppleFileServer guestAccess -bool false
defaults write SystemConfiguration/com.apple.smb.server AllowGuestAccess -bool false
