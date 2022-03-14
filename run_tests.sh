#!/bin/bash
#SBATCH -C gpu
#SBATCH -q debug
#SBATCH -N 1
#SBATCH -t 5
#SBATCH -o slurm-test-%j.out
#SBATCH -G 4
#SBATCH -A nstaff_g

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

. $cfg_file
conda activate $INSTALL_DIR
module list

srun -l -u python test_install.py --hvd
