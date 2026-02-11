#!/bin/bash

set -e # Abort on error

mkdir build && cd build
cmake ${CMAKE_ARGS} -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$PREFIX -GNinja ..
cmake --build . --target install

if [[ "$(uname)" == "Darwin" ]]; then
    echo "Checking all .dylib architectures in $PREFIX/lib..."
    for lib in "$PREFIX"/lib/*.dylib; do
        file "$lib"
    done
fi