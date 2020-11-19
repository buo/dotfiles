#!/bin/bash

brew list python >/dev/null 2>&1
if test $? -gt 0; then
	brew install python
fi

# Install pip
if test command -v pip >/dev/null 2>&1; then
	curl https://bootstrap.pypa.io/get-pip.py | sudo python
fi

# Install SpoofMAC
if test command -v spoof-mac >/dev/null 2>&1; then
	sudo pip install SpoofMAC
fi
