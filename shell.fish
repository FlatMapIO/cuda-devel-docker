#!/usr/bin/env fish

set -l tag $argv[1]
test -z "$tag"; set tag '12.1.1'

docker run --rm -it \
    --gpus all \
    --user sa \
    -v /etc/apt/sources.list:/etc/apt/sources.list \
    -v $HOME/.gitconfig:/home/sa/.gitconfig \
    -v $HOME/.cache:/home/sa/.cache \
    -v $HOME/.cargo:/home/sa/.cargo \
    -v $HOME/.config:/home/sa/.config \
    -v $HOME/.local:/home/sa/.local \
    -v $HOME/.vscode-insdiers:/home/sa/.vscode-insdiers \
    -v $HOME/.codeium:/home/sa/.codeium \
    -v $PWD:/workspace \
    huodon/cuda-devel:$tag
