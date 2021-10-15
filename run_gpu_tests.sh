#!/bin/bash
#SBATCH -C gpu
#SBATCH -N 2
#SBATCH --ntasks-per-node=4
#SBATCH --gpus-per-task=1
#SBATCH --cpus-per-task=32
#SBATCH -t 10
#SBATCH -o slurm-test-%j.out
#SBATCH -A nstaff_g

. config.sh --gpu $@
conda activate $INSTALL_DIR
module list

srun -l -u python test_install.py --hvd --cuda
