#!/usr/bin/env bash

# Arguments:
#   $1 FLAVOR_ENV dev / stag / prod.

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

FLAVOR_ENV=${1:?\
$(print_in_red "Missing argument \$1 FLAVOR_ENV dev / stag / prod.")}

./tool/android/start-emulator.sh
source ./tool/constants.sh

pushd android &> /dev/null

FLUTTER_TEST_ARG=$(printf "FLUTTER_TEST=true" | base64)
INSTALL_APP=":app:install${FLAVOR_ENV@u}Debug"
INSTALL_ANDROID_TEST=":app:install${FLAVOR_ENV@u}DebugAndroidTest"

flutter build apk --flavor "$FLAVOR_ENV" --debug

./gradlew "$INSTALL_ANDROID_TEST" \
  -Pdart-defines="$FLUTTER_TEST_ARG"

./gradlew "$INSTALL_APP" \
  -Pdart-defines="$FLUTTER_TEST_ARG" \
  -Ptarget="$(pwd)/../integration_test/golden_screenshots_test.dart"

popd &> /dev/null

APP_PACKAGE="$ANDROID_APP_ID.$FLAVOR_ENV.debug"
SCREENSHOT_DIR="app_flutter/screenshots"
REMOTE_DIR="/data/user/0/$APP_PACKAGE/$SCREENSHOT_DIR"
LOCAL_DIR="./android/fastlane/$FLAVOR_ENV/metadata/android/en-US/images/phoneScreenshots"
ACCESSIBLE_DIR="/storage/emulated/0/Download/$APP_NAME_KEBAB_CASE/screenshots"
IMAGE_NAME_SUFFIX="_en-US"
SCREENSHOTS=(
  "1"
  "2"
  "3"
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
  SCREENSHOT_FILE="${LOCAL_DIR}/${SCREENSHOT}${IMAGE_NAME_SUFFIX}.png"
  adb push "$SCREENSHOT_FILE" "$REMOTE_DIR"
done

if adb root | grep "adbd cannot run as root in production builds"; then
  adb shell <<- EOF
	run-as "$ANDROID_APP_ID.$FLAVOR_ENV.debug"
  mkdir -p $SCREENSHOT_DIR
  # $ACCESSIBLE_DIR is not accessible after run-as
	cp "$ACCESSIBLE_DIR/*" ./$SCREENSHOT_DIR
	exit
	exit
	EOF
fi

adb shell am instrument \
  -w "$ANDROID_APP_ID.$FLAVOR_ENV.debug.test/androidx.test.runner.AndroidJUnitRunner"

./tool/android/kill-emulator.sh || true
