#!/bin/bash
#SBATCH -C gpu
#SBATCH -N 1
#SBATCH -c 10
#SBATCH --gres=gpu:1
#SBATCH -t 2:00:00
#SBATCH -o slurm-build-%j.out

set -e

srun -n 1 ./build_env.sh
srun -n 1 ./build_tensorflow_conda.sh
srun -n 1 ./build_horovod.sh
