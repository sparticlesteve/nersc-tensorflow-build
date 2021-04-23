# Source me

# Configure the installation
export INSTALL_NAME="tensorflow"
export PYTHON_VERSION=3.8
export TF_VERSION="2.4.1"
export HOROVOD_VERSION="0.21.0"
export SYSTEM_ARCH=cpu
INSTALL_BASE=$SCRATCH/conda

# Parse command line options
while (( "$#" )); do
    case "$1" in
        --gpu)
            export SYSTEM_ARCH=gpu
            shift
            ;;
        --prod)
            # Production install, as swowner
            umask 002 # all-readable
            INSTALL_BASE=/usr/common/software
            shift
            ;;
        *)
            echo "Error: unsupport arg $1" >&2
            return 1
            ;;
    esac
done

export BUILD_DIR=$SCRATCH/tensorflow-build/$INSTALL_NAME/$TF_VERSION
export INSTALL_DIR=$INSTALL_BASE/$INSTALL_NAME/$TF_VERSION

# Cori-GPU configuration
if [[ $SYSTEM_ARCH == "gpu" ]]; then
    module purge
    module load cgpu
    module load gcc/7.3.0 #8.3.0
    module load cuda/11.0.3
    module load cudnn/8.0.5
    module load mpich/3.3.1-debug
    #module load openmpi/4.0.3
    module load nccl/2.8.4
    export BUILD_DIR=${BUILD_DIR}-gpu
    export INSTALL_DIR=${INSTALL_DIR}-gpu

# Cori-CPU configuration
else
    module unload PrgEnv-intel
    module load PrgEnv-gnu
    module unload craype-hugepages2M
    module unload atp
fi

# Setup conda
source /usr/common/software/python/3.8-anaconda-2020.11/etc/profile.d/conda.sh

# Print some stuff
echo "Configuring on $(hostname) as $USER"
echo "  Build directory $BUILD_DIR"
echo "  Install directory $INSTALL_DIR"
