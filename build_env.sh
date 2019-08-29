#!/bin/bash

# Configure the installation
source ./config.sh

# Make a conda env
conda create -y --prefix $INSTALL_DIR python=$PYTHON_VERSION \
    mkl mkl-include numpy pyyaml setuptools cmake cffi typing \
    h5py ipython ipykernel matplotlib scikit-learn pandas pillow

conda activate $INSTALL_DIR
conda install -y -c conda-forge ipympl

# If building TF from source
conda install -y bazel
