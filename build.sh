#!/usr/bin/env bash

# see also 
# - https://hub.docker.com/r/nvidia/cuda/tags
# - https://pytorch.org/get-started/previous-versions/
for version in "11.8.0" "12.4.1" "12.6.1"; do
    tag="${version}-cudnn-devel-ubuntu22.04"
    docker build \
        --build-arg TAG=$tag \
        -t huodon/cuda-devel:$version \
        ./docker
    docker push huodon/cuda-devel:$version
    docker rmi huodon/cuda-devel:$version
    docker image prune -f
    docker system prune -f
done