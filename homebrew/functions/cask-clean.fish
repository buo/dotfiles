function cask-clean
  git checkout master
  git branch | grep -v master | xargs git branch -D
end
