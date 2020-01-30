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
#$export LD_PRELOAD=$MVAPICH2_DIR/lib/libmpi.so
module list

echo
echo "-----------SINGLE GPU TEST------------"
srun -n 1 -u python test_install.py --cuda

echo
echo "-----------MULTI GPU TEST-------------"
srun --ntasks-per-node 8 -l -u python test_install.py --hvd #--cuda

echo
echo "-----------TRAINING TEST--------------"
srun --ntasks-per-node 8 -l -u python test_hvdmnist.py
