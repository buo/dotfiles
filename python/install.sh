#!/usr/bin/env bash

sudo pip install SpoofMAC
# Install pip
if test command -v pip >/dev/null 2>&1; then
	curl https://bootstrap.pypa.io/get-pip.py | sudo python
fi
