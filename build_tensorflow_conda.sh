#!/bin/bash

. config.sh
conda activate $INSTALL_DIR

# Install tensorflow with MKL-DNN
conda install -y -c anaconda tensorflow=${TF_VERSION:1}
