#!/bin/bash

# Make a conda env
conda create -y --prefix $INSTALL_DIR python=$PYTHON_VERSION \
    mkl mkl-include cmake cffi typing

# Install additional dependencies via pip
source $CONDA_INIT_SCRIPT
conda activate $INSTALL_DIR
pip install --no-cache-dir numpy pyyaml setuptools h5py ipython ipykernel ray \
    matplotlib scikit-learn pandas pillow ipympl tdqm wandb gpustat \
    tensorboard git+https://github.com/NERSC/nersc-tensorboard-helper.git
