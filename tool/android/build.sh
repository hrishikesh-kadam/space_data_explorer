#!/usr/bin/env bash

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

source ./tool/constants.sh

FLAVOR_ENV=$(./tool/get-flavor-env.sh)

if [[ -s ./secrets/.git ]]; then
  PLAY_VERSION_CODE=$(./tool/android/get-play-version-code.sh "$FLAVOR_ENV")
  log_info "PLAY_VERSION_CODE=$PLAY_VERSION_CODE"
  INCREMENTED_VERSION_CODE=$(( PLAY_VERSION_CODE+1 ))
  log_info "INCREMENTED_VERSION_CODE=$INCREMENTED_VERSION_CODE"
else
  INCREMENTED_VERSION_CODE=1
fi

flutter build appbundle \
  --flavor "$FLAVOR_ENV" \
  --dart-define="FLAVOR_ENV=$FLAVOR_ENV" \
  --build-number "$INCREMENTED_VERSION_CODE" \
  --split-debug-info="build/app/outputs/bundle/${FLAVOR_ENV}Release/debug-info" \
  --obfuscate

BUNDLE_FILE="./build/app/outputs/bundle/${FLAVOR_ENV}Release/app-${FLAVOR_ENV}-release.aab"

VERSION_CODE=$( \
  $BUNDLETOOL dump manifest \
    --bundle "$BUNDLE_FILE" \
    --xpath /manifest/@android:versionCode
)
log_info "VERSION_CODE=$VERSION_CODE"
VERSION_NAME=$( \
  $BUNDLETOOL dump manifest \
    --bundle "$BUNDLE_FILE" \
    --xpath /manifest/@android:versionName
)
log_info "VERSION_NAME=$VERSION_NAME"

./tool/android/check-all-variants.sh

pushd android &> /dev/null
./gradlew :app:build
popd &> /dev/null

if [[ $(uname -s) =~ ^"MINGW" ]]; then
  dos2unix ./android/fastlane/README.md
fi
