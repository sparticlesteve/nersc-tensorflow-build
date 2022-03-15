#!/bin/bash -e

# Download and extract the software
mkdir -p $BUILD_DIR && cd $BUILD_DIR
wget https://bitbucket.org/mpi4py/mpi4py/downloads/mpi4py-3.0.3.tar.gz
tar zxvf mpi4py-3.0.3.tar.gz
cd mpi4py-3.0.3

python setup.py build --mpicc=$MPICC
python setup.py install
