#!/bin/bash

./build_env.sh 2>&1 | tee log.env
./build_tensorflow_conda.sh 2>&1 | tee log.tensorflow
./build_horovod.sh 2>&1 | tee log.horovod
