ARG TAG=12.2.2-cudnn8-devel-ubuntu22.04

FROM nvidia/cuda:${TAG}

RUN apt-get update; \
  apt-get -y install sudo curl libgl1-mesa-dev libglib2.0-0

# RUN adduser --disabled-password --gecos '' sa
RUN groupadd --gid 1000 sa; \
  useradd --uid 1000 --gid 1000 -m sa; \
  echo sa ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/sa; \
  chmod 0440 /etc/sudoers.d/sa

USER sa
WORKDIR /workspace
RUN curl https://pkgx.sh | sh
RUN pkgx integrate

# RUN mkdir -p ~/.pkgx/fishshell.com/v\*/bin/; \
#   touch ~/.pkgx/fishshell.com/v\*/bin/fish; \
#   chmod +x ~/.pkgx/fishshell.com/v\*/bin/fish; \
#   sudo ln -s ~/.pkgx/fishshell.com/v\*/bin/fish /usr/local/bin/fish; \
#   rm -rf ~/.pkgx/fishshell.com

RUN echo '#!/usr/bin/env bash' > fish; \
  echo 'pkgx +fish -- fish "$@"' >> fish; \
  chmod +x fish; \
  sudo mv fish /usr/local/bin

# -------------------------------------------------
# cleanup
RUN sudo apt-get remove -y curl; \
  sudo apt-get autoremove; \
  sudo rm -rf /var/lib/apt/lists/*

CMD pkgx +fish fish