#!/usr/bin/env bash


# see also https://hub.docker.com/r/nvidia/cuda/tags
for version in "11.8.0" "12.1.0"; do
    tag="${version}-cudnn8-devel-ubuntu22.04"
    docker build \
        --build-arg TAG=$tag \
        -t huodon/cuda-devel:$tag \
        ./docker
    docker push huodon/cuda-devel:$tag
done