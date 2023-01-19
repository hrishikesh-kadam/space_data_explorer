#!/usr/bin/env bash

# $1 AVD_NAME like Pixel_6_API_33

# TODO(hrishikesh-kadam): Test this script on macOS and Windows

set -e

AVD_NAME=${1-"Pixel_6_API_33"}

if [[ $AVD_ALREADY_RUNNING == "false" ]]; then
  AVD_PID=$(pgrep -f "$AVD_NAME" | head -n1)
  if [[ $AVD_PID ]]; then
    kill "$AVD_PID"
    while kill -0 "$AVD_PID" 2> /dev/null; do
      sleep 1
    done
  fi
fi
