
## Runtime

- `nvidia/cuda:{11.8.0, 12.1.1, 12.2.2}-cudnn8-devel-ubuntu22.04`
- homebrew + common tools

## Enter shell

```fish
cd <you-workspace>

./shell.fish


# build anything
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