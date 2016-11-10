shell 'brew cask install atom'

packages = File.expand_path File.basename(__FILE__), 'packages.txt'
shell "apm install --packages-file #{packages}"
