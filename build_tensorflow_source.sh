#!/bin/bash

# Setup the environment
. config.sh
conda activate $INSTALL_DIR

# Configure the build
export CC=gcc
export CXX=g++
export PYTHON_BIN_PATH=$INSTALL_DIR/bin/python
export USE_DEFAULT_PYTHON_LIB_PATH=1
export TF_ENABLE_XLA=0
export TF_NEED_CUDA=0
export GCC_HOST_COMPILER_PATH=`which gcc`
export TF_NEED_MPI=0
export TF_NEED_TENSORRT=0
export TF_NEED_OPENCL_SYCL=0
export TF_NEED_ROCM=0
export TF_SET_ANDROID_WORKSPACE=0
export CC_OPT_FLAGS="-march=native"

# Checkout the code
mkdir -p $BUILD_DIR && cd $BUILD_DIR
[ -d tensorflow ] && rm -rf tensorflow
git clone -b $TF_VERSION https://github.com/tensorflow/tensorflow.git
cd tensorflow

# Run the build
./configure
bazel build --config=opt --config=cuda --config=mkl //tensorflow/tools/pip_package:build_pip_package
./bazel-bin/tensorflow/tools/pip_package/build_pip_package $BUILD_DIR/tensorflow_pkg

# Install the package
pip install $BUILD_DIR/tensorflow_pkg/tensorflow-*.whl
