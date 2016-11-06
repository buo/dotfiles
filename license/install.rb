unless cmd_exists? 'license'
  shell 'go get -u github.com/nishanths/license'
end
