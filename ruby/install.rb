#!/bin/sh

if os == :macos and !cmd_exists? 'bundle'
  shell 'sudo gem install bundler --bindir=/usr/local/bin'
end
