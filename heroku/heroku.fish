source completions.fish

function heroku-destroy
  set app $argv[1]
  heroku apps:destroy --app $app --confirm $app
end
