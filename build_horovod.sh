#!/bin/bash

. config.sh
conda activate $INSTALL_DIR

# Set compile flags
export CC=mpicc
export CXX=mpic++
#export CFLAGS="-g"
#export CXXFLAGS="-g"
#export HOROVOD_MPICXX_SHOW="$PWD/showMPI.sh"
#export HOROVOD_MPI_THREADS_DISABLE=1

pip install -v --no-cache-dir horovod==$HOROVOD_VERSION
