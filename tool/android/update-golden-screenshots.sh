#!/usr/bin/env bash

set -e -o pipefail

source ./tool/constants.sh

FLAVOR_ENV=$(./tool/get-flavor-env.sh)

AVD_NAMES=(
  "Pixel_7_API_34"
  "Nexus_7_API_34"
  "Nexus_10_API_34"
)
DEVICE_NAMES=(
  "pixel_7"
  "Nexus 7 2013"
  "Nexus 10"
)
SKIN_NAMES=(
  "pixel_7"
  "nexus_7_2013"
  "nexus_10"
)
IMAGE_NAME_SUFFIXES=(
  "_en-US"
  "_en-US"
  "_en-US"
)
GOLDEN_DIRECTORIES=(
  "android/fastlane/$FLAVOR_ENV/metadata/android/en-US/images/phoneScreenshots"
  "android/fastlane/$FLAVOR_ENV/metadata/android/en-US/images/sevenInchScreenshots"
  "android/fastlane/$FLAVOR_ENV/metadata/android/en-US/images/tenInchScreenshots"
)

# Reference - 
# https://docs.flutter.dev/testing/integration-tests
# https://github.com/flutter/flutter/issues/100292#issuecomment-1076927900
FLAVOR_ENV_ARG=$(printf "FLAVOR_ENV=%s" "$FLAVOR_ENV" | base64)
FLUTTER_TEST_ARG=$(printf "FLUTTER_TEST=true" | base64)
SCREENSHOT_TEST_ARG=$(printf "SCREENSHOT_TEST=true" | base64)
UPDATE_GOLDENS_ARG=$(printf "UPDATE_GOLDENS=true" | base64)
CONNECTED_ANDROID_TEST=":app:connected${FLAVOR_ENV@u}DebugAndroidTest"

APP_PACKAGE="$ANDROID_APP_ID.$FLAVOR_ENV.debug"
SCREENSHOT_DIR="app_flutter/screenshots"
REMOTE_DIR="/data/user/0/$APP_PACKAGE/$SCREENSHOT_DIR"
ACCESSIBLE_DIR="/storage/emulated/0/Download/$APP_NAME_KEBAB_CASE/screenshots"
SCREENSHOTS=(
  "1"
  "2"
  "3"
  "4"
  "5"
)

for i in {0..2}; do

  ./tool/android/start-emulator.sh \
    "${AVD_NAMES[i]}" "" "${DEVICE_NAMES[i]}" "${SKIN_NAMES[i]}"

  # flutter test \
  #   --flavor "$FLAVOR_ENV" \
  #   --dart-define="FLAVOR_ENV=$FLAVOR_ENV" \
  #   --dart-define="FLUTTER_TEST=true" \
  #   --dart-define="SCREENSHOT_TEST=true" \
  #   --dart-define="UPDATE_GOLDENS=true" \
  #   --dart-define="IMAGE_NAME_SUFFIX=${IMAGE_NAME_SUFFIXES[i]}" \
  #   integration_test/golden_screenshots_test.dart

  pushd android &> /dev/null

  IMAGE_NAME_SUFFIX_ARG=$(printf "IMAGE_NAME_SUFFIX=%s" "${IMAGE_NAME_SUFFIXES[i]}" | base64)

  ./gradlew "$CONNECTED_ANDROID_TEST" \
    -Pdart-defines="$FLAVOR_ENV_ARG,$FLUTTER_TEST_ARG,$SCREENSHOT_TEST_ARG,$UPDATE_GOLDENS_ARG,$IMAGE_NAME_SUFFIX_ARG" \
    -Ptarget="$(pwd)/../integration_test/golden_screenshots_test.dart"

  popd &> /dev/null

  LOCAL_DIR=${GOLDEN_DIRECTORIES[i]}
  mkdir -p "$LOCAL_DIR"

  if adb root | grep "adbd cannot run as root in production builds"; then
    # Tested on Samsung Galaxy S20 FE 5G API 33
    adb shell <<- EOF
		rm -rf $ACCESSIBLE_DIR
		mkdir -p $ACCESSIBLE_DIR
		run-as "$ANDROID_APP_ID.$FLAVOR_ENV.debug"
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
    SCREENSHOT_FILE="${REMOTE_DIR}/${SCREENSHOT}${IMAGE_NAME_SUFFIXES[i]}.png"
    adb pull "$SCREENSHOT_FILE" "$LOCAL_DIR"
  done

  ./tool/android/kill-emulator.sh "${AVD_NAMES[i]}" || true

done
