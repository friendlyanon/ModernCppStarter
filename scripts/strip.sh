#!/bin/sh

if [ "$#" -ne 1 ] || ! [ -f "$1" ]; then
  echo "Usage: $0 <path-to-binary>"
  exit 1
fi

EXE="$(basename "$1")"
TARGET="$(cd "$(dirname "$1")"; pwd)/$EXE"

sizeof() {
  du --apparent-size --block-size=1 "$1" | cut -f1
}

BEFORE="$(sizeof "$TARGET")"
strip -s "$TARGET" && echo "$EXE stripped: $BEFORE -> $(sizeof "$TARGET")"
