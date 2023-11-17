- 本镜像提供三个主要的 CUDA 版本开发环境, 用于构建和运行依赖 CUDA 环境的的应用
- 容器使用 sa 用户,如果 Host 同样使用 sa, 通过 volume 映射可以得到无缝的使用习惯
- [pkgx](https://pkgx.sh/)

## Usage

- 基础镜像:`nvidia/cuda:{11.8.0, 12.1.1, 12.2.2}-cudnn8-devel-ubuntu22.04`

```bash
docker pull huodon/cuda-devel:11.8.0
docker pull huodon/cuda-devel:12.1.1
docker pull huodon/cuda-devel:12.2.2
```


## Examples

### 构建 llama.cpp

```fish

cd <you-workspace>
git clone --depth 1 https://github.com/ggerganov/llama.cpp.git

# 进入容器 fish shell
../cuda-devel-docker/shell.fish # 或 ./shell.fish 12.2.2
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