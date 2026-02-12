#!/bin/bash

set -e # Abort on error

mkdir build && cd build
cmake ${CMAKE_ARGS} -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$PREFIX -GNinja ..
cmake --build . --target install
