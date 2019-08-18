"""Testing script for the TensorFlow and Horovod installation"""

import os
import argparse
import logging

import tensorflow as tf

# Suppress TF warnings
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'
tf.compat.v1.logging.set_verbosity(logging.ERROR)

import horovod.tensorflow as hvd

def main():
    print('Success')

if __name__ == '__main__':
    main()
