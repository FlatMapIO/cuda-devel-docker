ARG  TAG=12.2.2-cudnn8-devel-ubuntu22.04

FROM nvidia/cuda:${TAG}

WORKDIR /workspace

COPY ./install.sh /workspace

RUN ./install.sh

CMD fish
