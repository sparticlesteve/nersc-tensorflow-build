#!/bin/bash

# Build TensorFlow from source
# This is not currently working (Apr 2021, TF 2.4.1)

# Common config
export CC=gcc
export CXX=g++
export PYTHON_BIN_PATH=$INSTALL_DIR/bin/python
export USE_DEFAULT_PYTHON_LIB_PATH=1
#export TF_NEED_MPI=0
#export TF_NEED_OPENCL_SYCL=0
export TF_NEED_ROCM=0
export TF_SET_ANDROID_WORKSPACE=0
export TF_DOWNLOAD_CLANG=0
export TF_NEED_TENSORRT=0
export TF_CUDA_CLANG=0

# GPU build
if [[ $SYSTEM_ARCH == "gpu" ]]; then
    export TF_NEED_CUDA=1
    export TF_CUDA_PATHS=$CUDA_ROOT,$NCCL_DIR,$CUDNN_DIR
    export TF_CUDA_VERSION=11
    export TF_CUDNN_VERSION=8
    export TF_NCCL_VERSION=2.8.4
    export TF_CUDA_COMPUTE_CAPABILITIES=7.0
    export GCC_HOST_COMPILER_PATH=$GCC_PATH
    bazel_opts=""

# CPU build
else
    export TF_ENABLE_XLA=0
    export GCC_HOST_COMPILER_PATH=`which gcc`
    export CC_OPT_FLAGS="-march=native"
    export TF_NEED_CUDA=0
    bazel_opts="--config=mkl -c opt --copt=-mavx --copt=-mavx2 --copt=-mfma --copt=-mavx512f --copt=-mavx512pf --copt=-mavx512cd --copt=-mavx512er"
fi

# Checkout the code
mkdir -p $BUILD_DIR && cd $BUILD_DIR
[ -d tensorflow ] && rm -rf tensorflow
git clone -b v${TF_VERSION} https://github.com/tensorflow/tensorflow.git
cd tensorflow

# Run the build
./configure
bazel build $bazel_opts //tensorflow/tools/pip_package:build_pip_package
./bazel-bin/tensorflow/tools/pip_package/build_pip_package $BUILD_DIR/tensorflow_pkg

# Install the package
pip install $BUILD_DIR/tensorflow_pkg/tensorflow-*.whl
