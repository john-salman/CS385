#!/bin/bash
mkdir build -p && mkdir install -p
cd build/
cmake -DCMAKE_INSTALL_PREFIX=../install ../src
make
make install