# Install Homebrew on macOS
if os == :macos and !cmd_exists? "brew"
  ohai "Install Homebrew"
  `ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

  # Install Homebrew Cask
  unless cmd_exists? "brew cask"
    `brew tap caskroom/cask`
    # `brew tap caskroom/fonts`
    # `brew tap caskroom/unofficial`
    # `brew tap caskroom/versions`
  end

  # Clean up the cache files.
  `brew cleanup`
  `brew cask cleanup`
end
