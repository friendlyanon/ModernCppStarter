#!/bin/sh

CWD="$(cd "$(dirname "$0")" && pwd)"
TARGET="build/release"

cd $CWD/..

configure() {
  if [ -d $TARGET ]; then
    return 0
  fi

  cmake -Hstandalone -B $TARGET -GNinja \
    -DCMAKE_BUILD_TYPE=Release \
    -DUSE_CCACHE=ON \
    -DCMAKE_INTERPROCEDURAL_OPTIMIZATION=ON \
    -DCPM_SOURCE_CACHE="$(pwd)/.cpm-cache"
}

build() {
  cmake --build $TARGET --config Release
}

configure && build
