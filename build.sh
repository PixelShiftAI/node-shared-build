#!/bin/bash

set -ex

CMD=${1:-build_android}
TAG=${2:-14.2.0}

download_and_extract() {
  local FILENAME="v$TAG.tar.gz"

  curl -L https://github.com/nodejs/node/archive/${FILENAME} > $FILENAME
  tar zxvf "$FILENAME"
}


build_android() {
  ./android-configure $ANDROID_NDK_HOME arm64 23
  make -j4
}

# Run in subshell 
download_and_extract > /dev/null
(cd node-$TAG && $CMD)
