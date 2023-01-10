#!/usr/bin/env bash

set -e

AVD_NAME=Pixel_6_API_33
SYSTEM_IMAGE_PACKAGE_PATH="system-images;android-33;google_apis;x86_64"
DEVICE_NAME=pixel_6

if [[ $GITHUB_ACTIONS == "true" ]]; then
  PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
  PATH="$PATH:$ANDROID_SDK_ROOT/emulator"
  PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools"
  if [[ $RUNNER_OS == "Linux" ]]; then
    sudo apt-get install -y libpulse0
  fi
fi

yes | sdkmanager $SYSTEM_IMAGE_PACKAGE_PATH

if ! avdmanager list avd | grep $AVD_NAME; then
  avdmanager create avd --name $AVD_NAME \
    --package $SYSTEM_IMAGE_PACKAGE_PATH \
    --device $DEVICE_NAME
fi

if ! ls "$HOME/.android/avd/${AVD_NAME}.avd/hardware-qemu.ini.lock"; then
  emulator @$AVD_NAME &
else
  AVD_MAYBE_ALREADY_RUNNING=true
fi
# shellcheck disable=SC2016
adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done;'

echo "Start with flutter integration test"
# mapfile -t TARGET_PATHS < <(find integration_test -type f -name "*_test.dart")
TARGET_PATHS=(
  "integration_test/platform_specific_app_bar_test.dart"
)
for TARGET_PATH in "${TARGET_PATHS[@]}"; do
  flutter test "$TARGET_PATH"
done

if [[ ! $AVD_MAYBE_ALREADY_RUNNING ]]; then
  adb emu kill
fi
