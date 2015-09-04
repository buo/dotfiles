# Set language and text formats
defaults write NSGlobalDomain AppleLanguages -array "en" "ko"
defaults write NSGlobalDomain AppleLocale -string "ko_KR"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool false
