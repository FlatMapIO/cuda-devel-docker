#!/usr/bin/env bash

if [[ "$(whoami)" != "vscode" ]]; then
	echo "Error: You are not vscode user"
	exit 1
fi

echo ">>> setup base"
sudo apt-get update
sudo sudo apt install -y curl git libgl1-mesa-dev libglib2.0-0

echo ">>> install homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

sudo ln -s /home/vscode/linuxbrew/.linuxbrew /opt/homebrew

echo 'export PATH=/opt/homebrew/bin:$PATH' >>/home/vscode/.bashrc

echo ">>> install apps"

/opt/homebrew/bin/brew install \
	git git-lfs \
	ripgrep difftastic nvim \
	fish lsd bat htop aria2 fd \
	python ffmpeg

# clean
echo ">>> clean up"
sudo apt-get remove git curl
sudo rm -rf /var/lib/apt/lists/*
