#!/bin/bash
#SBATCH -C gpu
#SBATCH --gres=gpu:8
#SBATCH --exclusive
#SBATCH -N 1
#SBATCH -t 20
#SBATCH -o slurm-test-%j.out

set -e
. config.sh
conda activate $INSTALL_DIR

module list

# Single GPU test
srun -n 1 -u python test_install.py --cuda

# Multi-GPU tests
srun --ntasks-per-node 8 -l -u python test_install.py --hvd #--cuda
