#!/bin/bash

. config.sh
conda activate $INSTALL_DIR

# Set compile flags
export CRAYPE_LINK_TYPE=dynamic
export CC=cc
export CXX=CC
export CFLAGS="-g"
export CXXFLAGS="-g"
export HOROVOD_MPICXX_SHOW="$PWD/showMPI.sh"

pip install --no-cache-dir horovod
