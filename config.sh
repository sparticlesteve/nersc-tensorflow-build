# Source me

if [ $USER == "swowner" ]; then
    umask 002 # all-readable
    INSTALL_BASE=/usr/common/software
else
    INSTALL_BASE=$SCRATCH/conda
fi

# Configure the installation
export INSTALL_NAME="tensorflow-gpu"
export PYTHON_VERSION=3.7
export TF_VERSION="1.15.0"
export HOROVOD_VERSION="0.18.2"
export BUILD_DIR=$SCRATCH/tensorflow-build/$INSTALL_NAME/$TF_VERSION
export INSTALL_DIR=$INSTALL_BASE/$INSTALL_NAME/$TF_VERSION

# Setup programming environment
module load gcc/7.3.0
module load cuda/10.1.168 #cuda/10.0.130
module load mpich/3.3.1-debug
#module load mvapich2/2.3.2 #openmpi/4.0.1-ucx-1.6
#export MV2_ENABLE_AFFINITY=0

# Setup conda
source /usr/common/software/python/3.7-anaconda-2019.07/etc/profile.d/conda.sh

# Print some stuff
echo "Configuring on $(hostname) as $USER"
echo "  Build directory $BUILD_DIR"
echo "  Install directory $INSTALL_DIR"
