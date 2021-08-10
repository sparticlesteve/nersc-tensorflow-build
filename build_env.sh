#!/bin/bash

# Make a conda env
conda create -y --prefix $INSTALL_DIR python=$PYTHON_VERSION \
    mkl mkl-include cmake cffi typing

# Install additional dependencies via pip
source $CONDA_INIT_SCRIPT
conda activate $INSTALL_DIR
pip install --no-cache-dir numpy pyyaml setuptools h5py ipython ipykernel matplotlib \
    scikit-learn pandas pillow ipympl
