#!/bin/bash

set -e # Abort on error

mkdir build && cd build
cmake ${CMAKE_ARGS} -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$PREFIX -GNinja ..
cmake --build . --target install

if [[ "$(uname -m)" == "arm64" ]]; then
    echo "Verifying ARM64 architecture for .dylib files in $PREFIX/lib..."
    for lib in "$PREFIX"/lib/*.dylib; do
        if [[ ! -f "$lib" ]]; then
            echo "No .dylib files found in $PREFIX/lib, skipping check."
            break
        fi
        echo "Inspecting $lib"
        file "$lib"
        if ! file "$lib" | grep -q "arm64"; then
            echo "ERROR: $lib is not arm64."
            exit 1
        fi
    done
fi