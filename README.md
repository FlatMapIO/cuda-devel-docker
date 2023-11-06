- 本镜像提供三个主要的 CUDA 版本开发环境, 可用于构建依赖 CUDA 的应用而不把宿主 Host OS 弄的一团遭
- 安装了 homebrew 以及各种常用的开发环境和命令行工具, 比如 lsd fd rg python cmake 等
- 容器使用 sa 用户,如果 Host 同样使用 sa, 通过 volume 映射可以得到无缝的使用习惯

## Runtime

- 基础镜像:`nvidia/cuda:{11.8.0, 12.1.1, 12.2.2}-cudnn8-devel-ubuntu22.04`
- 工具: homebrew + 各种命令行工具以及开发工具


## Enter shell

构建 llama.cpp

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

## Examples

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