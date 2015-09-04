# Set the timezone; see `systemsetup -listtimezones` for other values
sudo systemsetup -settimezone "Asia/Seoul" > /dev/null

# Set date and time automatically
sudo systemsetup -setusingnetworktime on > /dev/null

# Set time server (Apple Asia)
sudo systemsetup -setnetworktimeserver "time.asia.apple.com" > /dev/null

# Set time zome automatically using current location
sudo defaults write /Library/Preferences/com.apple.timezone.auto.plist Active -bool true

# Menu bar clock format
# "h:mm" Default
# "HH"   Use a 24-hour clock
# "a"    Show AM/PM
# "ss"   Display the time with seconds
defaults write com.apple.menuextra.clock DateFormat -string "HH:mm:ss"

# Flash the time separators
defaults write com.apple.menuextra.clock FlashDateSeparators -bool false

# Analog menu bar clock
defaults write com.apple.menuextra.clock IsAnalog -bool false
