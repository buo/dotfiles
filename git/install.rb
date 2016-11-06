unless File.exists? "#{DOTROOT}/git/gitconfig.symlink"
  name = ask "What is your Git author name?"
  email = ask "What is your email address?", "#{name}@users.noreply.github.com"
  credential = os == :macos ? "osxkeychain" : "cache"

  gitconfig = File.read "#{DOTROOT}/git/gitconfig.symlink.example"
  gitconfig.gsub! "AUTHORNAME", name
  gitconfig.gsub! "AUTHOREMAIL", email
  gitconfig.gsub! "GIT_CREDENTIAL_HELPER", credential

  File.write "#{DOTROOT}/git/gitconfig.symlink", gitconfig
end
