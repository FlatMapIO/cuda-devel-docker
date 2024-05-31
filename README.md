- 本镜像提供三个主要的 CUDA 版本开发环境, 用于构建和运行依赖 CUDA 环境的的应用
- 容器用户为 sa, 不污染 root 用户, 避免各种非 root 软件安装时遇到麻烦
- 在基础镜像上只安装了 [pkgx](https://pkgx.sh/)
- 目录映射使容器和宿主有几乎相同的使用习惯和体验, 避免发生频繁且重复的网络 IO
## Usage

- 基础镜像:`nvidia/cuda:{11.8.0, 12.4.1}-cudnn8-devel-ubuntu22.04`

```bash
docker pull huodon/cuda-devel:11.8.0
docker pull huodon/cuda-devel:12.4.1
```


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
    -v $HOME/.vscode-insdiers:/home/sa/.vscode-insdiers \
    -v $HOME/.codeium:/home/sa/.codeium \
    -v $HOME/.pkgx:/home/sa/.pkgx \
    -v /home/linuxbrew:/home/linuxbrew \
    -v $PWD:/workspace \
    huodon/cuda-devel:12.2.2
```

## Examples

### 构建 llama.cpp


```fish
cd <you-workspace>
git clone --depth 1 https://github.com/ggerganov/llama.cpp.git
```

turch docker-compose.yml

```yml
version: "3.8"

services:
  app:
    image: huodon/cuda-devel:12.1.1
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
      - ~/.config:/home/sa/.config
      - ~/.cache:/home/sa/.cache
      - ~/.vscode-server:/home/sa/.vscode-server
      - ~/.vscode-server-insiders:/home/sa/.vscode-server-insiders
      - ~/.codeium/:/home/sa/.codeium
      - ~/.cargo/:/home/sa/.cargo
      # ====================================================================
      - ../Nodels/:/Models
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

### build onnxruntime-cuda

```fish
mkdir onnxruntime-build; cd onnxruntime-build

git clone --depth 1 https://github.com/microsoft/onnxruntime.git

# Enter shell
../cuda-devel-docker/shell.fish

# docker session
cd onnxruntime-build/onnxruntime
pip install -r tools/ci_build/github/linux/docker/inference/x64/python/cpu/scripts/requirements.txt

./build.sh --allow_running_as_root \
  --skip_submodule_sync \
  --cuda_home /usr/local/cuda \
  --cudnn_home /usr/lib/x86_64-linux-gnu/ \
  --use_cuda \
  --config Release \
  --build_wheel --update \
  --build --parallel \
  --cmake_extra_defines ONNXRUNTIME_VERSION=$(cat ./VERSION_NUMBER) \
  CMAKE_CUDA_ARCHITECTURES=native

# pip3 install /build/Linux/Release/dist/*.whl
```

## 常见问题

### cv2 模块找不到 libgl.so 等
```
pip uninstall python-opencv
pip install python-opencv-headless
```

