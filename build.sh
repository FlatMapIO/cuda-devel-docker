#!/usr/bin/env bash

# see also https://hub.docker.com/r/nvidia/cuda/tags
for version in "11.8.0" "12.1.1"; do
    tag="${version}-cudnn8-devel-ubuntu22.04"
    docker build \
        --build-arg TAG=$tag \
        -t huodon/cuda-devel:$version \
        ./docker
    docker push huodon/cuda-devel:$version
    docker rmi huodon/cuda-devel:$version
    docker image prune -f
    docker system prune -f
done