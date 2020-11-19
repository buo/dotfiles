#!/bin/bash

if [ "$(uname -s)" == "Darwin" ]; then
  current_hostname=$(hostname)
  read -p "What is the name of this machine? [$current_hostname] " new_hostname
  if [ -z "$new_hostname" ]; then
    new_hostname="$current_hostname"
  fi

  HOSTNAME=$new_hostname sh -c "${DOTROOT}/osx/preferences.sh"
fi