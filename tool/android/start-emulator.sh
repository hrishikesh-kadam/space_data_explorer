#!/usr/bin/env bash

# TODO(hrishikesh-kadam): Make android-34 as default

# $1 AVD_NAME like Pixel_6_API_33
# $2 SYSTEM_IMAGE_PACKAGE_PATH like "system-images;android-33;google_apis;x86_64"
# $3 DEVICE_NAME like pixel_6

set -e -o pipefail

# ./tool/android/start-emulator-actions-prerequisite.sh

if [[ $(uname -m) == "arm64" ]]; then
  SYSTEM_IMAGE_ARCH="arm64-v8a"
else
  SYSTEM_IMAGE_ARCH="x86_64"
fi

AVD_NAME=${1:-"Pixel_6_API_33"}
SYSTEM_IMAGE_PACKAGE_PATH=${2:-"system-images;android-33;google_apis;$SYSTEM_IMAGE_ARCH"}
DEVICE_NAME=${3:-"pixel_6"}

if [[ $(uname -s) =~ ^"MINGW" ]]; then
  SdkManager="sdkmanager.bat"
  AvdManager="avdmanager.bat"
else
  SdkManager="sdkmanager"
  AvdManager="avdmanager"
fi

AVD_PID=$(./tool/android/avd-already-running.sh "$AVD_NAME")
if [[ -z $AVD_PID ]]; then
  AVD_ALREADY_RUNNING=false
  if ! ls "$HOME/.android/avd/${AVD_NAME}.ini"; then
    if [[ ! -d "$ANDROID_HOME/${SYSTEM_IMAGE_PACKAGE_PATH//;//}" ]]; then
      $SdkManager --install "$SYSTEM_IMAGE_PACKAGE_PATH"
    fi
    $AvdManager create avd --name "$AVD_NAME" \
      --package "$SYSTEM_IMAGE_PACKAGE_PATH" \
      --device "$DEVICE_NAME"
  fi
  emulator "@$AVD_NAME" &
else
  AVD_ALREADY_RUNNING=true
fi

echo "AVD_ALREADY_RUNNING=$AVD_ALREADY_RUNNING"

# shellcheck disable=SC2016
adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done;'
