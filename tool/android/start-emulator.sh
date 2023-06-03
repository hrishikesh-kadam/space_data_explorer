#!/usr/bin/env bash

# $1 AVD_NAME like Pixel_6_API_33
# $2 SYSTEM_IMAGE_PACKAGE_PATH like "system-images;android-33;google_apis;x86_64"
# $3 DEVICE_NAME like pixel_6

if [ -z ${-%*e*} ]; then PARENT_ERREXIT=true; else PARENT_ERREXIT=false; fi
if shopt -qo pipefail; then PARENT_PIPEFAIL=true; else PARENT_PIPEFAIL=false; fi

set -e -o pipefail

./tool/android/start-emulator-actions-prerequisite.sh

if [[ $(uname -m) == "arm64" ]]; then
  SYSTEM_IMAGE_ARCH="arm64-v8a"
else
  SYSTEM_IMAGE_ARCH="x86_64"
fi

AVD_NAME=${1:-"Pixel_6_API_33"}
SYSTEM_IMAGE_PACKAGE_PATH=${2:-"system-images;android-33;google_apis;$SYSTEM_IMAGE_ARCH"}
DEVICE_NAME=${3:-"pixel_6"}

if ! pgrep -f "$AVD_NAME"; then
  export AVD_ALREADY_RUNNING=false
  if ! ls "$HOME/.android/avd/${AVD_NAME}.ini"; then
    if [[ ! -d "$ANDROID_HOME/${SYSTEM_IMAGE_PACKAGE_PATH//;//}" ]]; then
      sdkmanager --install "$SYSTEM_IMAGE_PACKAGE_PATH"
    fi
    avdmanager create avd --name "$AVD_NAME" \
      --package "$SYSTEM_IMAGE_PACKAGE_PATH" \
      --device "$DEVICE_NAME"
  fi
  emulator "@$AVD_NAME" &
else
  export AVD_ALREADY_RUNNING=true
fi

unset AVD_NAME
unset SYSTEM_IMAGE_PACKAGE_PATH
unset SYSTEM_IMAGE_ARCH
unset DEVICE_NAME

echo "AVD_ALREADY_RUNNING=$AVD_ALREADY_RUNNING"

# shellcheck disable=SC2016
adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done;'

if [ $PARENT_ERREXIT = "true" ]; then set -e; else set +e; fi
if [ $PARENT_PIPEFAIL = "true" ]; then set -o pipefail; else set +o pipefail; fi
