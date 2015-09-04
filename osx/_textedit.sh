# Open and save files as UTF-8 encoded
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Use plain text mode for new documents
defaults write com.apple.TextEdit RichText -int 0
