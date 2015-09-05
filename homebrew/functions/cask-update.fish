# Updating an app is not supported by brew cask so far.
# To update an app, you need to delete the previous version first and then
# install the lastest version.
function cask-update
  set cask $argv[1]
  if test -d /opt/homebrew-cask/Caskroom/$cask
    rm -rf /opt/homebrew-cask/Caskroom/$cask
  end
  brew cask install $cask
end
