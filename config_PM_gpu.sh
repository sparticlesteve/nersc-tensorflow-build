# Source me

# Configure the installation
export INSTALL_NAME="tensorflow"
export PYTHON_VERSION=3.9
export TF_VERSION="2.9.0"
export HOROVOD_VERSION="0.24.3"

if [ $USER == "swowner" ]; then
    umask 002 # all-readable
    INSTALL_BASE=/global/common/software/nersc/pm-2022q4/sw
else
    INSTALL_BASE=$SCRATCH/conda
fi

export BUILD_DIR=$SCRATCH/tensorflow-build/$INSTALL_NAME/$TF_VERSION
export INSTALL_DIR=$INSTALL_BASE/$INSTALL_NAME/$TF_VERSION


# PM configuration
module load PrgEnv-gnu gcc/11.2.0
module load cudatoolkit/11.7
module load cudnn/8.3.2
module load nccl/2.15.5-ofi
module load evp-patch
export BUILD_DIR=${BUILD_DIR}
export INSTALL_DIR=${INSTALL_DIR}

export CXX=CC #g++
export CC=cc #gcc
# should be mpicc for Cori gpu, otherwise cc
export MPICC=cc

# Setup conda
export CONDA_INIT_SCRIPT=/global/common/software/nersc/pm-2021q4/sw/python/3.9-anaconda-2021.11/etc/profile.d/conda.sh
source $CONDA_INIT_SCRIPT

# Print some stuff
echo "Configuring on $(hostname) as $USER"
echo "  Build directory $BUILD_DIR"
echo "  Install directory $INSTALL_DIR"
