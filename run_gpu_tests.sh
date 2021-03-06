#!/bin/bash
#SBATCH -C gpu
#SBATCH -N 1
#SBATCH --ntasks-per-node=2
#SBATCH --gpus-per-task=1
#SBATCH --cpus-per-task=10
#SBATCH -t 10
#SBATCH -o slurm-test-%j.out

. config.sh --gpu $@
conda activate $INSTALL_DIR
module list

srun -l -u python test_install.py --hvd --cuda
