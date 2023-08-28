#!/bin/bash
#SBATCH -C gpu
#SBATCH -N 1 -n 1 -G 1 -c 32 -t 30
#SBATCH -o slurm-build-%j.out
#SBATCH -A nstaff_g

# Abort on failure
set -e -o pipefail

export cfg_file=config_PM_gpu.sh

# Configure
. $cfg_file $@

# Build the conda environment
./build_env.sh
conda activate $INSTALL_DIR

# Install tensorflow
./install_tensorflow.sh

# Build Horovod
./build_horovod.sh

# MPI4Py
./build_mpi4py.sh


