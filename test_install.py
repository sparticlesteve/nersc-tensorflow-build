"""Testing script for the TensorFlow and Horovod installation"""

import os
import argparse
import logging

import tensorflow as tf

# Suppress TF warnings
#os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'

def test_hvd():
    import horovod.tensorflow as hvd
    hvd.init()
    print('rank', hvd.rank(), 'local', hvd.local_rank(), 'size', hvd.size())

def test_cuda():
    print('Built with CUDA:', tf.test.is_built_with_cuda())
    print('GPUs available:', tf.config.list_physical_devices('GPU'))

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--hvd', action='store_true')
    parser.add_argument('--cuda', action='store_true')
    parser.add_argument('--all', action='store_true')
    args = parser.parse_args()

    # Run the tests
    if args.hvd or args.all:
        test_hvd()
    if args.cuda or args.all:
        test_cuda()

    print('Finished')

if __name__ == '__main__':
    main()
