#!/usr/bin/env bash

set -e

if [[ $(uname -s)  =~ ^"Darwin" ]]; then
  brew install diffutils
fi

pip install csv2md

if [[ ! $CI ]]; then
  if [[ ! -s $ANDROID_HOME/bundletool-all.jar ]]; then
    ./tool/android/install-bundletool.sh
  fi
fi
