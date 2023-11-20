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

# -------------------------------------------------
# cleanup
RUN sudo apt-get remove -y curl; \
  sudo apt-get autoremove; \
  sudo rm -rf /var/lib/apt/lists/*

CMD pkgx +python@3.11 fish