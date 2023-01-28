#!/usr/bin/env bash

set -e -o pipefail

source ./tool/android/start-emulator.sh
source ./tool/constants.sh

FLAVOR_ENV=$(./tool/get-flavor-env.sh)

pushd android &> /dev/null

FLUTTER_TEST_ARG=$(printf 'FLUTTER_TEST=true' | base64)
INSTALL_APP="app:install${FLAVOR_ENV@u}Debug"
INSTALL_ANDROID_TEST="app:install${FLAVOR_ENV@u}DebugAndroidTest"

flutter build apk --flavor "$FLAVOR_ENV" --debug

./gradlew "$INSTALL_ANDROID_TEST" \
  -Pdart-defines="$FLUTTER_TEST_ARG"

./gradlew "$INSTALL_APP" \
  -Pdart-defines="$FLUTTER_TEST_ARG" \
  -Ptarget="$(pwd)/../integration_test/golden_screenshots_test.dart"

popd &> /dev/null

APP_PACKAGE="$APPLICATION_ID.$FLAVOR_ENV.debug"
SCREENSHOT_DIR="app_flutter/screenshots"
REMOTE_DIR="/data/user/0/$APP_PACKAGE/$SCREENSHOT_DIR"
LOCALE_DIR="./android/app/src/$FLAVOR_ENV/play/listings/en-US/graphics/phone-screenshots"
ACCESSIBLE_DIR="/storage/emulated/0/Download/$APP_NAME_KEBAB_CASE/screenshots"
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
	exit
	EOF
  REMOTE_DIR="$ACCESSIBLE_DIR"
else
  # Tested on Emulator Pixel 6 API 33
  sleep 2
  adb shell mkdir -p "$REMOTE_DIR"
fi

for SCREENSHOT in "${SCREENSHOTS[@]}"; do
  adb push "$LOCALE_DIR/$SCREENSHOT" "$REMOTE_DIR"
done

if adb root | grep "adbd cannot run as root in production builds"; then
  adb shell <<- EOF
	run-as "$APPLICATION_ID.$FLAVOR_ENV.debug"
  mkdir -p $SCREENSHOT_DIR
  # $ACCESSIBLE_DIR is not accessible after run-as
	cp "$ACCESSIBLE_DIR/*" ./$SCREENSHOT_DIR
	exit
	exit
	EOF
fi

adb shell am instrument \
  -w "$APPLICATION_ID.$FLAVOR_ENV.debug.test/androidx.test.runner.AndroidJUnitRunner"

./tool/android/kill-emulator.sh
