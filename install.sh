#!/bin/bash
#SBATCH -C gpu
#SBATCH -N 1 -n 1 -G 1 -c 32 -t 30
#SBATCH -o slurm-build-%j.out
#SBATCH -A nstaff_g

# Abort on failure
set -e -o pipefail

for i in "$@"; do
    case $i in
        --system_arch=*)
            # Parse system and hardware flag
            # Format: {PM, Cori}_{cpu, gpu}
            # e.g., --system_arch=PM_gpu for Perlmutter GPU
            export SYSTEM_ARCH="${i#*=}"
            parsed_cfg_file="config_${SYSTEM_ARCH}.sh"
            if [ ! -f $parsed_cfg_file ]; then
                echo "Error: no config file for $i"
                exit 1
            fi
            export cfg_file=${parsed_cfg_file:-config_PM_gpu.sh}

            shift
            ;;
        *)
            echo "Error: unsupported arg $1" >&2
            exit 1
            ;;
    esac
done

export cfg_file=${parsed_cfg_file:-config_PM_gpu.sh}
export SYSTEM_ARCH=${SYSTEM_ARCH:-PM_gpu}

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


