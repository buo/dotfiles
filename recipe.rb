# Requirements
install :git
install :python
install :ruby
install :homebrew if os == :macos

install :aws
install "fish/install.sh"
install :hub
install "iterm/install.sh"
install :license

install "osx/preferences.sh" if os == :macos
