#!/bin/bash -e

# Install TF binaries

# Install tensorflow with pip
pip3 install --disable-pip-version-check --no-cache-dir tensorflow==$TF_VERSION tensorflow-datasets keras==$TF_VERSION tensorflow-estimator==$TF_VERSION

# Install via conda
#conda install -y -c anaconda tensorflow=$TF_VERSION
#conda install -y tensorflow=2.4.1=gpu_py38h8a7d6ce_0
