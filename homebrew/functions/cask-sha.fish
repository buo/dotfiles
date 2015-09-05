# Create sha256 hashes from files.
function cask-sha
  shasum -a 256 $argv
end
