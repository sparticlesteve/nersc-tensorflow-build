#!/bin/bash
#SBATCH -C gpu
#SBATCH -N 1
#SBATCH --gres=gpu:8
#SBATCH --exclusive
#SBATCH -t 2:00:00
#SBATCH -o slurm-build-%j.out

set -e

echo
echo "-----------BUILD env-----------"
srun -n 1 ./build_env.sh

echo
echo "-----------BUILD tensorflow-----------"
srun -n 1 ./build_tensorflow_conda.sh
srun -n 1 #./build_tensorflow_source.sh

echo
echo "-----------BUILD horovod-----------"
srun -n 1 ./build_horovod.sh

echo "-----------DONE-----------"
