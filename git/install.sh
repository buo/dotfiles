# https://stackoverflow.com/a/246128
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Upgrade Git to the official latest one from the pre-installed Apple Git.
if [ "$(which git)" = "/usr/bin/git" ]; then
  brew install git
fi

if [ ! -f "$DIR/gitconfig.symlink" -o ! -f "$HOME/.gitconfig" ]; then
  git_credential="cache"
  if [ "$(uname -s)" == "Darwin" ]; then
    git_credential="osxkeychain"
  fi

  read -ep "What is your git user name? " git_user_name
  read -ep "What is your git email address? [${git_user_name}@users.noreply.github.com] " git_user_email

  if [ -z "$git_user_email" ]; then
    git_user_email="${git_user_name}@users.noreply.github.com"
  fi

  sed -e "s/AUTHORNAME/$git_user_name/g" -e "s/AUTHOREMAIL/$git_user_email/g" -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" "$DIR/gitconfig.symlink.example" > "$DIR/gitconfig.symlink"

  symlink "$DIR/gitconfig.symlink" "$HOME/.gitconfig"
fi
