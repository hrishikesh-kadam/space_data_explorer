#!/usr/bin/env bash

# $1 AVD_NAME like Pixel_6_API_34

set -e -o pipefail

AVD_NAME=${1:-"Pixel_6_API_34"}

AVD_PID=$(./tool/android/avd-already-running.sh "$AVD_NAME")
if [[ -z $AVD_PID ]]; then
  exit 1
fi

if [[ $(uname -s) =~ ^"MINGW" ]]; then
  taskkill //pid "$AVD_PID"
  while [[ ! $output =~ "No tasks are running" ]]; do
    output=$(tasklist \
      //fi "STATUS eq running" \
      //fi "PID eq $AVD_PID" \
    )
    sleep 1
  done
else
  kill "$AVD_PID"
  while kill -0 "$AVD_PID" 2> /dev/null; do
    sleep 1
  done
fi
