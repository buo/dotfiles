function cask-clean
  git checkout master
  for branch in (git branch | grep -v master)
    set branch (echo "$branch" | sed 's/^[[:space:]]*//')
    git branch -D "$branch"
    git push buo ":$branch"
  end
end
