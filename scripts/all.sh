#!/bin/sh

CWD="$(cd "$(dirname "$0")" && pwd)"

# release build is omitted on purpose
$CWD/test.sh && $CWD/standalone.sh && $CWD/docs.sh
