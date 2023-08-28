#!/bin/bash
#SBATCH -C gpu
#SBATCH -q debug
#SBATCH -N 1
#SBATCH -t 5
#SBATCH -o slurm-test-%j.out
#SBATCH -G 4
#SBATCH -A nstaff_g

export cfg_file=config_PM_gpu.sh

. $cfg_file
conda activate $INSTALL_DIR
module list

srun -l -u python test_install.py --hvd
