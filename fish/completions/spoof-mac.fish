function __fish_spoof_mac_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 ]
    return 0
  end
  return 1
end

function __fish_spoof_mac_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

# list
complete -f -c spoof-mac -n '__fish_spoof_mac_needs_command' -a list -d 'List available devices'
complete -f -c spoof-mac -n '__fish_spoof_mac_using_command list' -l wifi -d 'List available Wi-Fi devices'

# randomize
complete -f -c spoof-mac -n '__fish_spoof_mac_needs_command' -a randomize -d 'Randomize MAC address'
complete -f -c spoof-mac -n '__fish_spoof_mac_using_command randomize' -l local -d 'Randomize MAC address with locally administered flag'

# set
complete -f -c spoof-mac -n '__fish_spoof_mac_needs_command' -a set -d 'Set device MAC address to something specific'

# reset
complete -f -c spoof-mac -n '__fish_spoof_mac_needs_command' -a reset -d 'Reset device to its original MAC address'

# normalize
complete -f -c spoof-mac -n '__fish_spoof_mac_needs_command' -a normalize -d 'Normalize MAC address'

# options
complete -f -c spoof-mac -n '__fish_spoof_mac_needs_command' -a '-h --help' -d 'Display help'
complete -f -c spoof-mac -n '__fish_spoof_mac_needs_command' -a '--version' -d 'Print version number of spoof-mac'
