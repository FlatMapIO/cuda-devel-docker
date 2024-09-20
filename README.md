
- 在基础镜像上只安装了 [pkgx](https://pkgx.sh/)
- 容器用户为 sa, 目的是与 host 中的 sa 用户映射目录. 避免重复安装各种工具和依赖. 

## Shell

```sh
# 以下 volume 映射可保持容器和宿主在使用上几乎相同.
docker run --rm -it \
    --gpus all \
    -v /etc/apt/sources.list:/etc/apt/sources.list \
    -v $HOME/.gitconfig:/home/sa/.gitconfig \
    -v $HOME/.cache:/home/sa/.cache \
    -v $HOME/.cargo:/home/sa/.cargo \
    -v $HOME/.config:/home/sa/.config \
    -v $HOME/.local:/home/sa/.local \
    -v $HOME/.vscode-server:/home/sa/.vscode-insdiers \
    -v $HOME/.pkgx:/home/sa/.pkgx \
    -v /home/linuxbrew:/home/linuxbrew \
    -v $PWD:/workspace \
    huodon/cuda-devel:12.6.1
```

## Examples

### 构建 llama.cpp


```fish
cd <you-workspace>
git clone --depth 1 https://github.com/ggerganov/llama.cpp.git
```

turch docker-compose.yml

```yml
services:
  app:
    image: huodon/cuda-devel:12.4.1
    shm_size: 1gb
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: all
              capabilities: [gpu]
    user: sa
    working_dir: /workspace
    volumes:
      - /etc/apt/sources.list:/etc/apt/sources.list \
      - ~/.config:/home/sa/.config
      - ~/.cache:/home/sa/.cache
      - ~/.vscode-server:/home/sa/.vscode-server
      - ~/.codeium/:/home/sa/.codeium
      - ~/.cargo/:/home/sa/.cargo
      # ====================================================================
      - .:/workspace
    ports:
      - 8080:8080
```


```fish
# install deps
env +python@3.11 +cmake

# build
mkdir build; cd build
cmake .. -DLLAMA_CUBLAS=ON
cmake --build . --config Release

ls bin
```

