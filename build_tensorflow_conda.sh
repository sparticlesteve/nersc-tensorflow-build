#!/bin/bash

. config.sh
conda activate $INSTALL_DIR

# Install tensorflow with CUDA
conda install -y -c anaconda tensorflow-gpu=${TF_VERSION:1}
