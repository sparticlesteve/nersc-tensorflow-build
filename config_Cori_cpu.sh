# ---------- UNTESTED -----------
# Source me

# Configure the installation
export INSTALL_NAME="cpu-tensorflow"
export PYTHON_VERSION=3.9
export TF_VERSION="2.8.0"
export HOROVOD_VERSION="0.24.1"

if [ $USER == "swowner" ]; then
    umask 002 # all-readable
    INSTALL_BASE=/usr/common/software
else
    INSTALL_BASE=$SCRATCH/conda
fi

export BUILD_DIR=$SCRATCH/tensorflow-build/$INSTALL_NAME/$TF_VERSION
export INSTALL_DIR=$INSTALL_BASE/$INSTALL_NAME/$TF_VERSION

# Setup programming environment
module swap PrgEnv-intel PrgEnv-gnu
module load gcc

export CXX=CC #g++
export CC=cc #gcc
# should be mpicc for Cori gpu, otherwise cc
export MPICC=mpicc

# Setup conda
export CONDA_INIT_SCRIPT=/usr/common/software/python/3.9-anaconda-2021.11/etc/profile.d/conda.sh
source $CONDA_INIT_SCRIPT

# Print some stuff
echo "Configuring on $(hostname) as $USER"
echo "  Build directory $BUILD_DIR"
echo "  Install directory $INSTALL_DIR"

