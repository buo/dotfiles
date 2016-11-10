require 'fileutils'
require 'securerandom'

if os == :macos
  shell 'brew install alfred'
  theme_dir = File.join(Dir.home, 'Library', 'Application Support', 'Alfred 3', 'Alfred.alfredpreferences', 'themes')
  if File.exists? theme_dir
    dir = File.join(theme_dir, "theme.fileimport.#{SecureRandom.uuid.upcase}")
    FileUtils.mkdir dir

    src = File.expand_path(File.dirname(__FILE__), 'theme.json')
    dst = File.join(dir, 'theme.json')
    FileUtils.cp(src, dst)
  end

  # TODO update prefs.plist
end
