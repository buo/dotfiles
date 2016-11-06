if os == :macos
  hostname = ask 'What is the name of this machine?'
  shell "HOSTNAME='#{hostname}' sh -c '#{DOTROOT}/osx/preferences.sh'"
end
