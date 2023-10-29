ARG  TAG=12.2.2-cudnn8-devel-ubuntu22.04

FROM nvidia/cuda:${TAG}

RUN apt-get update && \
  apt-get -y install curl git

# RUN adduser --disabled-password --gecos '' vscode
RUN useradd -m vscode

WORKDIR /workspace


RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	ln -s /home/vscode/linuxbrew/.linuxbrew /opt/homebrew; \
	/opt/homebrew/bin/brew install \
		git git-lfs \
		ripgrep difftastic nvim \
		fish lsd bat htop aria2 fd \
		python ffmpeg

RUN apt-get remove -y git curl; \
   rm -rf /var/lib/apt/lists/*

USER vscode
ENV PATH=/opt/homebrew/bin:$PATH

CMD fish
