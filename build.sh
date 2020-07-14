#!/bin/bash

set -ex

# Used in ./configure.
export OPTIONS="--without-npm --with-intl=small-icu --shared"

CMD=${1:-build_x86_64}
TAG=${2:-14.2.0}

download_and_extract() {
  local FILENAME="v$TAG.tar.gz"

  curl -L https://github.com/nodejs/node/archive/${FILENAME} > $FILENAME
  tar zxvf "$FILENAME"
  cp configure node-$TAG/
}


build-android-arm64() {
  ./android-configure $ANDROID_NDK_HOME arm64 23
  make -j4
}

build-x86-64() {
  ./configure --dest-cpu x86_64
  make -j4
}

# Run in subshell 
download_and_extract > /dev/null
(cd node-$TAG && $CMD)
