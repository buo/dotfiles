unless cmd_exists? 'go'
  shell 'brew install go' if os == :macos
end
