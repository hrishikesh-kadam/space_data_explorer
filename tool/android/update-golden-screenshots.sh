#!/usr/bin/env bash

set -e -o pipefail

source ./tool/android/start-emulator.sh

FLAVOR_ENV=$(./tool/get-flavor-env.sh)

# flutter test \
#   --flavor "$FLAVOR_ENV" \
#   --dart-define="FLUTTER_TEST=true" \
#   --dart-define="UPDATE_GOLDENS=true" \
#   integration_test/golden_screenshots_test.dart

pushd android &> /dev/null

# Reference https://github.com/flutter/flutter/issues/100292#issuecomment-1076927900
FLUTTER_TEST_ARG=$(printf 'FLUTTER_TEST=true' | base64)
UPDATE_GOLDENS_ARG=$(printf 'UPDATE_GOLDENS=true' | base64)
CONNECTED_ANDROID_TEST="app:connected${FLAVOR_ENV@u}DebugAndroidTest"

./gradlew "$CONNECTED_ANDROID_TEST" \
  -Pdart-defines="$FLUTTER_TEST_ARG" \
  -Pdart-defines="$UPDATE_GOLDENS_ARG" \
  -Ptarget="$(pwd)/../integration_test/golden_screenshots_test.dart"

popd &> /dev/null

source ./tool/constants.sh

APP_PACKAGE="$APPLICATION_ID.$FLAVOR_ENV.debug"
SCREENSHOT_DIR="app_flutter/screenshots"
REMOTE_DIR="/data/user/0/$APP_PACKAGE/$SCREENSHOT_DIR"
LOCALE_DIR="./android/app/src/$FLAVOR_ENV/play/listings/en-US/graphics/phone-screenshots"
ACCESSIBLE_DIR="/storage/emulated/0/Download/$APP_NAME_KEBAB_CASE/screenshots"
mkdir -p "$LOCALE_DIR"
SCREENSHOTS=(
  "1.png"
  "2.png"
  "3.png"
)

if adb root | grep "adbd cannot run as root in production builds"; then
  # Tested on Samsung Galaxy S20 FE 5G API 33
  adb shell <<- EOF
	rm -rf $ACCESSIBLE_DIR
	mkdir -p $ACCESSIBLE_DIR
	run-as "$APPLICATION_ID.$FLAVOR_ENV.debug"
	cp "./$SCREENSHOT_DIR/*" $ACCESSIBLE_DIR
	exit
	exit
	EOF
  REMOTE_DIR="$ACCESSIBLE_DIR"
else
  # Tested on Emulator Pixel 6 API 33
  sleep 2
fi

for SCREENSHOT in "${SCREENSHOTS[@]}"; do
  adb pull "$REMOTE_DIR/$SCREENSHOT" "$LOCALE_DIR"
done

./tool/android/kill-emulator.sh
