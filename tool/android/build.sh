#!/usr/bin/env bash

set -e -o pipefail

source ./tool/set-logs-env.sh
PRINT_DEBUG_LOG=1

FLAVOR_ENV=$(./tool/get-flavor-env.sh)

flutter build appbundle --flavor "$FLAVOR_ENV"

BUNDLE_FILE="./build/app/outputs/bundle/${FLAVOR_ENV}Release/app-${FLAVOR_ENV}-release.aab"

BUNDLETOOL_PATH="$ANDROID_HOME/bundletool-all.jar"
if [[ ! -s $BUNDLETOOL_PATH ]]; then
  ./tool/android/install-bundletool.sh
fi
BUNDLETOOL="java -jar $BUNDLETOOL_PATH"

VERSION_CODE=$($BUNDLETOOL dump manifest --bundle "$BUNDLE_FILE" --xpath /manifest/@android:versionCode)
debug_log "VERSION_CODE=$VERSION_CODE"
VERSION_NAME=$($BUNDLETOOL dump manifest --bundle "$BUNDLE_FILE" --xpath /manifest/@android:versionName)
debug_log "VERSION_NAME=$VERSION_NAME"

./tool/android/check-all-variants.sh

# TODO(hrishikesh-kadam): Uncomment this LABEL:contri
# pushd android &> /dev/null
# ./gradlew app:build
# popd &> /dev/null
