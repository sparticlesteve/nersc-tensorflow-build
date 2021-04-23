#!/bin/bash
#SBATCH -C gpu
#SBATCH -N 1 -n 1 -G 1 -c 20 -t 30
#SBATCH -o slurm-build-%j.out

# Abort on failure
set -e -o pipefail

# Configure
. config.sh --gpu $@

# Build the conda environment
./build_env.sh
conda activate $INSTALL_DIR

# Install tensorflow
./install_tensorflow.sh

# Build Horovod
./build_horovod.sh

# MPI4Py
./build_mpi4py.sh
