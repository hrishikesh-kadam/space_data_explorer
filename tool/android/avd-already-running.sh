#!/usr/bin/env bash

# $1 AVD_NAME like Pixel_6_API_33

set -e -o pipefail

AVD_NAME=${1:-"Pixel_6_API_33"}

if [[ $(uname -s) =~ ^"MINGW" ]]; then
  output=$(tasklist \
      //fi "STATUS eq running" \
      //fi "WINDOWTITLE eq Android Emulator - $AVD_NAME*" \
      //fo list \
  )
  if [[ $output =~ "No tasks are running" ]]; then
    exit 1
  fi
  AVD_PID=$(echo "$output" \
    | grep PID \
    | awk '{print $2}' \
  )
else
  AVD_PID=$(pgrep -f "$AVD_NAME" \
    | awk '{print $1}' \
  )
  if [[ -z $AVD_PID ]]; then
    exit 1
  fi
fi

echo "$AVD_PID"
