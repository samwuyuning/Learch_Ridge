#!/bin/bash

rm -rf /build
mkdir build
cd build
cmake -DENABLE_SOLVER_STP=ON -DENABLE_POSIX_RUNTIME=ON -DENABLE_KLEE_UCLIBC=ON -DKLEE_UCLIBC_PATH=~/klee-uclibc -DENABLE_UNIT_TESTS=OFF -DENABLE_SYSTEM_TESTS=OFF -DLLVM_CONFIG_BINARY=/usr/bin/llvm-config -DLLVMCC=/usr/bin/clang -DLLVMCXX=/usr/bin/clang++ -DLIB_PYTHON=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu/libpython3.6m.so -DPYTHON_INCLUDE_DIRS=/usr/include/python3.6m/ ..
make -j8
make install
