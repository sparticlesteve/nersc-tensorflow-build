#!/bin/bash
#SBATCH -C haswell
#SBATCH -q debug
#SBATCH -N 2
#SBATCH -t 5
#SBATCH -o slurm-test-%j.out

. config.sh
conda activate $INSTALL_DIR
module list

srun -l -u python test_install.py --hvd
