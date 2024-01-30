# Source me

# Configure the installation
export INSTALL_NAME="tensorflow"
export PYTHON_VERSION=3.9
export TF_VERSION="2.15.0"
export HOROVOD_VERSION="0.28.1"

if [ $USER == "swowner" ]; then
    umask 002 # all-readable
    INSTALL_BASE=/global/common/software/nersc/pm-stable/sw
else
    INSTALL_BASE=$SCRATCH/conda
fi

export BUILD_DIR=$SCRATCH/tensorflow-build/$INSTALL_NAME/$TF_VERSION
export INSTALL_DIR=$INSTALL_BASE/$INSTALL_NAME/$TF_VERSION


# PM configuration
module load PrgEnv-gnu gcc-native/12.3
module load cudatoolkit/12.2
module load cudnn/8.9.3_cuda12
module load nccl/2.18.3-cu12
module load evp-patch
export BUILD_DIR=${BUILD_DIR}
export INSTALL_DIR=${INSTALL_DIR}

export CXX=CC
export CC=cc
export MPICC=cc

# Setup conda
module load conda

# Extra flags for TF XLA compilation
export XLA_FLAGS=--xla_gpu_cuda_data_dir=$CUDA_HOME

# Print some stuff
echo "Configuring on $(hostname) as $USER"
echo "  Build directory $BUILD_DIR"
echo "  Install directory $INSTALL_DIR"
