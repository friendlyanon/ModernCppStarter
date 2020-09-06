#!/bin/sh

CWD="$(cd "$(dirname "$0")" && pwd)"
TARGET="build/standalone"

cd $CWD/..

configure() {
  if [ -d $TARGET ]; then
    return 0
  fi

  cmake -Hstandalone -B $TARGET -GNinja \
    -DUSE_CCACHE=ON \
    -DCPM_SOURCE_CACHE="$(pwd)/.cpm-cache"
}

build() {
  cmake --build $TARGET
}

configure && build
