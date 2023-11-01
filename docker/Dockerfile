ARG  TAG=12.2.2-cudnn8-devel-ubuntu22.04

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

FROM nvidia/cuda:${TAG}

RUN apt-get update && \
  apt-get -y install sudo curl git

# RUN adduser --disabled-password --gecos '' vscode
RUN groupadd --gid $USER_GID $USERNAME; \
  useradd --uid $USER_UID --gid $USER_GID -m $USERNAME; \
  echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME; \
  chmod 0440 /etc/sudoers.d/$USERNAME


USER vscode
WORKDIR /workspace

RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	sudo ln -s /home/linuxbrew/.linuxbrew /opt/homebrew; \
	/opt/homebrew/bin/brew install \
		git git-lfs \
		ripgrep difftastic nvim \
		fish lsd bat htop aria2 fd \
		python ffmpeg cmake ninja

RUN sudo apt-get remove -y git curl; \
  sudo rm -rf /var/lib/apt/lists/*

ENV PATH=/opt/homebrew/bin:$PATH

CMD fish
