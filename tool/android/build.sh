#!/usr/bin/env bash

set -e -o pipefail

source ./tool/set-logs-env.sh
PRINT_INFO_LOG=1
source ./tool/constants.sh

FLAVOR_ENV=$(./tool/get-flavor-env.sh)

if [[ -s ./secrets/.git ]]; then
  PLAY_VERSION_CODE=$(./tool/android/get-play-version-code.sh "$FLAVOR_ENV")
  info_log "PLAY_VERSION_CODE=$PLAY_VERSION_CODE"
  INCREMENTED_VERSION_CODE=$(( PLAY_VERSION_CODE+1 ))
  info_log "INCREMENTED_VERSION_CODE=$INCREMENTED_VERSION_CODE"
else
  INCREMENTED_VERSION_CODE=1
fi

flutter build appbundle \
  --flavor "$FLAVOR_ENV" \
  --build-number "$INCREMENTED_VERSION_CODE"

BUNDLE_FILE="./build/app/outputs/bundle/${FLAVOR_ENV}Release/app-${FLAVOR_ENV}-release.aab"

VERSION_CODE=$( \
  $BUNDLETOOL dump manifest \
    --bundle "$BUNDLE_FILE" \
    --xpath /manifest/@android:versionCode
)
info_log "VERSION_CODE=$VERSION_CODE"
VERSION_NAME=$( \
  $BUNDLETOOL dump manifest \
    --bundle "$BUNDLE_FILE" \
    --xpath /manifest/@android:versionName
)
info_log "VERSION_NAME=$VERSION_NAME"

./tool/android/check-all-variants.sh

pushd android &> /dev/null
./gradlew app:build
popd &> /dev/null
