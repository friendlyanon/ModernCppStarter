#!/bin/sh

CWD="$(cd "$(dirname "$0")" && pwd)"
TARGET="build/documentation"

cd $CWD/..

configure() {
  if [ -d $TARGET ]; then
    return 0
  fi

  cmake -Hdocumentation -B $TARGET \
    -DCPM_SOURCE_CACHE="$(pwd)/.cpm-cache"
}

build() {
  cmake --build $TARGET --target GenerateDocs
}

configure && build
