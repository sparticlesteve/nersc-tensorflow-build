#!/bin/bash -e

# https://horovod.readthedocs.io/en/stable/install_include.html

export HOROVOD_WITH_TENSORFLOW=1
export HOROVOD_WITHOUT_PYTORCH=1
export HOROVOD_WITHOUT_MXNET=1

echo "Using NCCL for hvd GPU operations"
export HOROVOD_GPU_OPERATIONS=NCCL
export HOROVOD_NCCL_LINK=SHARED

pip install -v --no-cache-dir horovod==$HOROVOD_VERSION
