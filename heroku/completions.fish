function __fish_heroku_myapps
  set a (heroku apps)
  echo $a[2..-2] | tr ' ' '\n'
end

complete -f -c heroku-destroy -a '(__fish_heroku_myapps)'
