#!/usr/bin/env bash

# $1 AVD_NAME like Pixel_7_Pro_API_34

set -e -o pipefail

AVD_NAME=${1:-"Pixel_7_Pro_API_34"}

if [[ $(uname -s) =~ ^"MINGW" ]]; then
  output=$(tasklist \
    //fi "STATUS eq running" \
    //fi "WINDOWTITLE eq Android Emulator - $AVD_NAME*" \
    //fo list)
  if [[ $output =~ "No tasks are running" ]]; then
    exit 0
  fi
  output_lines=$(echo "$output" | grep --count PID)
else
  output=$(pgrep --list-full --full "emulator/qemu.*$AVD_NAME") || true
  if [[ -z $output ]]; then
    exit 0
  fi
  output_lines=$(echo "$output" | wc --lines)
fi

if (( output_lines > 1 )); then
  error="Multiple instances of the $AVD_NAME are running"
  printf "%b%s%b\n" "\033[31m" "$error" "\033[0m" >&2
  exit 1
fi

if [[ $(uname -s) =~ ^"MINGW" ]]; then
  AVD_PID=$(echo "$output" | grep PID | awk 'NR == 1 { print $2 }')
else
  AVD_PID=$(echo "$output" | awk 'NR == 1 { print $1 }')
fi

echo "$AVD_PID"
