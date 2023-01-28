#!/usr/bin/env bash

# Deprecated, Not in use

# $1 - AVD_NAME

set -e -o pipefail

AVD_NAME=$1

if ! ls "$HOME/.android/avd/${AVD_NAME}.avd/hardware-qemu.ini.lock"; then
  AVD_MAYBE_ALREADY_RUNNING=false
else
  ADB_DEVICES_OUTPUT=$(adb devices)
  if (( $(echo "$ADB_DEVICES_OUTPUT" | wc -l) > 1 )); then
    echo "$ADB_DEVICES_OUTPUT"
    AVD_MAYBE_ALREADY_RUNNING=true
  else
    AVD_MAYBE_ALREADY_RUNNING=false
  fi
fi

echo "AVD_MAYBE_ALREADY_RUNNING=$AVD_MAYBE_ALREADY_RUNNING"
if [[ $AVD_MAYBE_ALREADY_RUNNING == "true" ]]; then
  exit 0
else
  exit 1
fi
