#!/bin/bash

# Function to append a line to a file if it doesn't already exist
append_line_to_file() {
  local line="$1"
  local file="$2"

  if ! grep -qF "$line" "$file"; then
    echo "$line" >>"$file"
  else
    echo "The line already exists in $file. Skipping..."
  fi
}

if type -t brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  append_line_to_file 'eval "$(/opt/homebrew/bin/brew shellenv)"' "$HOME/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi


brew cleanup