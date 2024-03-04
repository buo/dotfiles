#!/bin/bash

if [ ! -d "/Applications/Hyper.app" ]; then
    echo "Hyper is not installed. Installing Hyper..."
    brew install hyper
else
    echo "Hyper is already installed."
fi

install_if_not_installed() {
    local plugin="$1"

    if hyper list | grep -qF "$plugin"; then
        echo "$plugin is already installed. Skipping..."
    else
        echo "Installing $plugin..."
        hyper i "$plugin"
    fi
}

# hyperterm-summon is a Hyper plugin for toggling terminal windows with a hotkey and restoring focus to the last active window in multi-window setups.
install_summon() {
    install_if_not_installed "hyperterm-summon"
    
    sed -i '' '/preserveCWD: true,/a\
        summon: {\
            hideDock: false,\
            hideOnBlur: false,\
            hotkey: "Ctrl+/",\
        },
    ' ~/.hyper.js
}

install_summon

# verminal is a beautiful theme for Hyper and other developer tools.
install_if_not_installed "verminal"