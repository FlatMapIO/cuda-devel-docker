#!/usr/bin/env fish

docker run --rm -it \
    --gpus all \
    --user vscode \
    -v /etc/apt/sources.list:/etc/apt/sources.list \
    -v $HOME/.gitconfig:/home/vscode/.gitconfig \
    -v $HOME/.cache:/home/vscode/.cache \
    -v $HOME/.config:/home/vscode/.config \
    -v $HOME/.local:/home/vscode/.local \
    -v $HOME/.vscode-insdiers:/home/vscode/.vscode-insdiers \
    -v $HOME/.codeium:/home/vscode/.codeium \
    -v $PWD:/workspace \
    huodon/cuda-devel:12.1.1
