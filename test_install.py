"""Testing script for the TensorFlow and Horovod installation"""

import os
import argparse
import logging

import tensorflow as tf

# Suppress TF warnings
#os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'
#tf.compat.v1.logging.set_verbosity(logging.ERROR)

def test_hvd():
    import horovod.tensorflow as hvd
    hvd.init()
    print('rank', hvd.rank(), 'local', hvd.local_rank(), 'size', hvd.size())

def test_cuda():
    print('Built with CUDA:', tf.test.is_built_with_cuda())
    print('GPU available:', tf.test.is_gpu_available())
    print('GPU device name:', tf.test.gpu_device_name())

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
