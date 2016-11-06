unless cmd_exists? 'pip'
  puts 'Install pip'
	shell 'curl https://bootstrap.pypa.io/get-pip.py | sudo python'
end

unless cmd_exists? 'spoof-mac'
  puts 'Install SpoofMAC'
  shell 'sudo pip install SpoofMAC'
end
