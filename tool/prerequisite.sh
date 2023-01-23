#!/usr/bin/env bash

set -e

source ./tool/set-logs-env.sh

JAVA_CLASS_MAJOR_VERSION=$( \
  javap -verbose java.lang.String \
    | grep "major version" \
    | cut -d " " -f 5 \
)
: "${JAVA_CLASS_MAJOR_VERSION:=-1}"
if (( "$JAVA_CLASS_MAJOR_VERSION" < 55 )); then
  error_log "Install JDK 11"
  exit 1
fi

if [[ $(uname -s) =~ ^"Darwin" ]]; then
  brew install diffutils
fi

pip install csv2md

if [[ ! $CI ]]; then
  if [[ ! -s $ANDROID_HOME/bundletool-all.jar ]]; then
    ./tool/android/install-bundletool.sh
  fi
fi

if [[ ! -x $(command -v yq) ]]; then
  if [[ $(uname -s) =~ ^"Linux" ]]; then
    sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 \
      -O /usr/bin/yq
    sudo chmod +x /usr/bin/yq
  elif [[ $(uname -s) =~ ^"Darwin" ]]; then
    brew install yq
  else
    choco install yq
  fi
fi
