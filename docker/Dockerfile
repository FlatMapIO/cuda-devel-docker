ARG TAG=12.2.2-cudnn8-devel-ubuntu22.04

FROM nvidia/cuda:${TAG}
# FROM ubuntu

RUN apt-get update && \
  apt-get -y install sudo curl git

# RUN adduser --disabled-password --gecos '' vscode
RUN groupadd --gid 1000 vscode; \
  useradd --uid 1000 --gid 1000 -m vscode; \
  echo vscode ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/vscode; \
  chmod 0440 /etc/sudoers.d/vscode

USER vscode
WORKDIR /workspace

RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	sudo ln -s /home/linuxbrew/.linuxbrew /opt/homebrew; \
	/opt/homebrew/bin/brew install \
		git git-lfs \
		ripgrep difftastic nvim \
		fish lsd bat htop aria2 fd \
		python ffmpeg cmake ninja

RUN /opt/homebrew/bin/brew cleanup --prune=all; \
	sudo apt-get remove -y git curl; \
  sudo rm -rf /var/lib/apt/lists/*

ENV PATH=/opt/homebrew/bin:$PATH

CMD fish
