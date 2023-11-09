ARG TAG=12.2.2-cudnn8-devel-ubuntu22.04

FROM nvidia/cuda:${TAG}
# FROM ubuntu

RUN apt-get update && \
  apt-get -y install sudo curl git

# RUN adduser --disabled-password --gecos '' sa
RUN groupadd --gid 1000 sa; \
  useradd --uid 1000 --gid 1000 -m sa; \
  echo sa ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/sa; \
  chmod 0440 /etc/sudoers.d/sa

USER sa
WORKDIR /workspace

RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	sudo ln -s /home/linuxbrew/.linuxbrew /opt/homebrew; \
	/opt/homebrew/bin/brew install \
		git git-lfs \
		ripgrep difftastic nvim \
		fish lsd bat htop aria2 fd \
		rustup-init python ffmpeg cmake ninja

RUN rustup-init -y

# -------------------------------------------------
# cleanup
RUN /opt/homebrew/bin/brew cleanup --prune=all; \
	sudo apt-get remove -y git curl; \
  sudo rm -rf /var/lib/apt/lists/*

ENV PATH=//opt/homebrew/bin:/home/sa/.cargo/bin:$PATH
ENV HOMEBREW_CURL_PATH=/opt/homebrew/bin/curl

CMD fish
