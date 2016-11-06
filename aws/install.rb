unless cmd_exists? 'aws --version'
  puts 'Install Amazon AWS command-line interface'
  `brew install awscli`
end
