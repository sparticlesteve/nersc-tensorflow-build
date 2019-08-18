#!/bin/bash

./build_env.sh 2>&1 | tee build_env.log
./build_tensorflow.sh 2>&1 | tee build_tensorflow.log
./build_horovod.sh 2>&1 | tee build_horovod.log
