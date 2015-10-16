#!/usr/bin/env bash

# Install pip
if test command -v pip >/dev/null 2>&1; then
	curl https://bootstrap.pypa.io/get-pip.py | sudo python
fi

# Install SpoofMAC
if test command -v spoof-mac >/dev/null 2>&1; then
	sudo pip install SpoofMAC
fi
