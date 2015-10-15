function cask-commit
  set cask $argv

  # Get the version of the app
  set info (brew cask info $cask)
  echo $info[2] | cut -f1 -d ',' | read -a name
  echo $info[1] | tr -s "\n" | read -a vars
  set ver $vars[2]

  # Test cask
  brew cask cleanup
  brew cask fetch $cask

  echo "$cask: $name ($ver)"
  echo "continue(y/Y)? "
  read input

  switch $input
  case y Y
    git checkout master
    git checkout -b "$cask-$ver"
    git add "Casks/$cask.rb"
    git commit -m "Update $name to $ver"
    # TODO parse the remote repository's name
    git push buo
    git checkout master
  end
end

function __fish_cask_commit_casks
  command git status | grep "modified:   Casks/" | tr -d '\t ' | cut -d ':' -f2 | sed 's/Casks\///' | sed 's/.rb//'
end

complete -c cask-commit -f -a '(__fish_cask_commit_casks)'
