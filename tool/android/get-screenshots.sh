#!/usr/bin/env bash

set -e

source ./tool/android/start-emulator.sh

FLAVOR=$(./tool/android/get-flavor.sh)

flutter run \
  --flavor "$FLAVOR" \
  --dart-define="FLUTTER_TEST=true" \
  integration_test/get_screenshots_test.dart

# pushd android &> /dev/null
# ./gradlew "app:connected${FLAVOR@u}DebugAndroidTest" \
#   -Ptarget="$(pwd)/../integration_test/get_screenshots_test.dart"
# popd &> /dev/null

source ./tool/constants.sh

set -e

REMOTE_DIR="/storage/emulated/0/Android/data/$APPLICATION_ID.$FLAVOR.debug/files"
LOCALE_DIR="./android/app/src/$FLAVOR/play/listings/en-US/graphics/phone-screenshots"
mkdir -p "$LOCALE_DIR"
SCREENSHOTS=(
  "1.png"
  "2.png"
  "3.png"
)
for SCREENSHOT in "${SCREENSHOTS[@]}"; do
  adb pull "$REMOTE_DIR/$SCREENSHOT" "$LOCALE_DIR"
done

./tool/android/kill-emulator.sh
