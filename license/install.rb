unless cmd_exists? 'license'
  shell 'brew tap tcnksm/license'
  shell 'brew install license'
end
