ARG  TAG=12.2.2-cudnn8-devel-ubuntu22.04

FROM nvidia/cuda:${TAG}

USER vscode

WORKDIR /workspace

ENV PATH=/opt/homebrew/bin:$PATH

RUN echo "USER: $(whoami)"

COPY ./install.sh /workspace

RUN ./install.sh

CMD fish
