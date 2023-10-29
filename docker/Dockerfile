ARG  TAG=12.2.2-cudnn8-devel-ubuntu22.04

FROM nvidia/cuda:${TAG}

RUN apt-get update && \
  apt-get -y install curl git

# RUN adduser --disabled-password --gecos '' vscode
RUN useradd -m vscode

USER vscode

WORKDIR /workspace

ENV PATH=/opt/homebrew/bin:$PATH

RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

RUN sudo ln -s /home/vscode/linuxbrew/.linuxbrew /opt/homebrew

RUN /opt/homebrew/bin/brew install \
	git git-lfs \
	ripgrep difftastic nvim \
	fish lsd bat htop aria2 fd \
	python ffmpeg

RUN sudo apt-get remove git curl; \
  sudo rm -rf /var/lib/apt/lists/*

CMD fish
