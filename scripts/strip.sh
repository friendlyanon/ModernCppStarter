#!/bin/sh

if [ "$#" -ne 1 ] || ! [ -f "$1" ]; then
  echo "Usage: $0 <path-to-binary>"
  exit 1
fi

TARGET="$(cd "$(dirname "$1")"; pwd)/$(basename "$1")"

strip -v -s "$TARGET"
