# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Delay Until Repeat
defaults write NSGlobalDomain "InitialKeyRepeat_Level_Saved" -int 15

# Set the key repeat rate to fast
defaults write NSGlobalDomain KeyRepeat -int 2

# Disable smart quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Add 2-Set Korean Input Source
# Caution! Do not use old style plist. It does not support number value, so it
# will parse 0 as a string.
defaults write com.apple.HIToolbox.plist AppleEnabledInputSources -array \
"<dict>
  <key>InputSourceKind</key><string>Keyboard Layout</string>
  <key>KeyboardLayout Name</key><string>U.S.</string>
  <key>KeyboardLayout ID</key><integer>0</integer>
</dict>" \
"<dict>
  <key>InputSourceKind</key><string>Input Mode</string>
  <key>Bundle ID</key><string>com.apple.inputmethod.Korean</string>
  <key>Input Mode</key><string>com.apple.inputmethod.Korean.2SetKorean</string>
</dict>" \
"<dict>
  <key>InputSourceKind</key><string>Keyboard Input Method</string>
  <key>Bundle ID</key><string>com.apple.inputmethod.Korean</string>
</dict>"

# Modifier Keys
# None            : -1
# Caps Lock       : 0
# Shift (Left)    : 1
# Control (Left)  : 2
# Option (Left)   : 3
# Command (Left)  : 4
# Keypad 0        : 5
# Help            : 6
# Shift (Right)   : 9
# Control (Right) : 10
# Option (Right)  : 11
# Command (Right) : 12
kbid=$(ioreg -n IOHIDKeyboard -r | grep -e VendorID\" -e ProductID | tr -d "|\"[:blank:]" | cut -d\= -f2 | tr "\n" -)
defaults -currentHost write -g "com.apple.keyboard.modifiermapping.${kbid}0" "
  <array>
    <dict>
      <key>HIDKeyboardModifierMappingSrc</key><integer>2</integer>
      <key>HIDKeyboardModifierMappingDst</key><integer>0</integer>
    </dict>
    <dict>
      <key>HIDKeyboardModifierMappingSrc</key><integer>0</integer>
      <key>HIDKeyboardModifierMappingDst</key><integer>2</integer>
    </dict>
  </array>
"
