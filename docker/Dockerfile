ARG TAG=12.6.1-cudnn-devel-ubuntu22.04

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


RUN curl https://pkgx.sh | sh; pkgx integrate

RUN	sudo ln -s /home/linuxbrew/.linuxbrew /opt/homebrew

# -------------------------------------------------
# cleanup

RUN sudo apt-get remove -y git curl; \
  sudo rm -rf /var/lib/apt/lists/*

ENV HOMEBREW_CURL_PATH=/opt/homebrew/bin/curl
ENV MODULAR_HOME=$HOME/.modular
ENV PATH=$HOME/.local/bin:/opt/homebrew/bin:$HOME/.cargo/bin:$HOME/.bun/bin:$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH

# CMD which fish && fish -l || pkgx +fish fish -l
