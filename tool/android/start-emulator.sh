#!/usr/bin/env bash

# $1 AVD_NAME like Pixel_7_Pro_API_34
# $2 SYSTEM_IMAGE_PACKAGE_PATH like "system-images;android-34;google_apis;x86_64"
# $3 DEVICE_NAME like pixel_7_pro

set -e -o pipefail

# ./tool/android/start-emulator-actions-prerequisite.sh

if [[ $(uname -m) == "arm64" ]]; then
  SYSTEM_IMAGE_ARCH="arm64-v8a"
else
  SYSTEM_IMAGE_ARCH="x86_64"
fi

AVD_NAME=${1:-"Pixel_7_Pro_API_34"}
SYSTEM_IMAGE_PACKAGE_PATH=${2:-"system-images;android-34;google_apis;$SYSTEM_IMAGE_ARCH"}
DEVICE_NAME=${3:-"pixel_7_pro"}

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
      --device "$DEVICE_NAME" \
      --skin "$DEVICE_NAME"
  fi
  emulator "@$AVD_NAME" &
else
  AVD_ALREADY_RUNNING=true
fi

echo "AVD_ALREADY_RUNNING=$AVD_ALREADY_RUNNING"

# shellcheck disable=SC2016
adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done;'
