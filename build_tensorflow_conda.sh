#!/bin/bash

. config.sh
conda activate $INSTALL_DIR

# Install tensorflow with MKL-DNN
conda install -y -c anaconda tensorflow-gpu=1.14.0
