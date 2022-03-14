#!/bin/bash -e

# https://horovod.readthedocs.io/en/stable/install_include.html

export HOROVOD_WITH_TENSORFLOW=1
export HOROVOD_WITHOUT_PYTORCH=1
export HOROVOD_WITHOUT_MXNET=1

# GPU build
if [[ ${SYSTEM_ARCH##*_} == "gpu" ]]; then
    echo "Using NCCL for hvd GPU operations"
    export HOROVOD_GPU_OPERATIONS=NCCL

# CPU build
else
    export CRAYPE_LINK_TYPE=dynamic
    export CC=cc
    export CXX=CC
    export CFLAGS="-g"
    export CXXFLAGS="-g"
    export HOROVOD_MPICXX_SHOW="$PWD/showMPI.sh"
fi

echo " ---- Env for hvd install: ----"
module list

pip install -v --no-cache-dir horovod==$HOROVOD_VERSION
