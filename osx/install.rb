if os == :macos
  default = `hostname`.chomp
  hostname = ask 'What is the name of this machine?', default
  shell "HOSTNAME='#{hostname}' sh -c '#{DOTROOT}/osx/preferences.sh'"
end
