#!/usr/bin/env bash

set -e

source ./tool/set-logs-env.sh
PRINT_DEBUG_LOG=1

FLAVOR=$(./tool/android/get-flavor.sh)

BUNDLE_FILE="./build/app/outputs/bundle/${FLAVOR}Release/app-${FLAVOR}-release.aab"

BUNDLETOOL_PATH="$ANDROID_HOME/bundletool-all.jar"
if [[ ! -s $BUNDLETOOL_PATH ]]; then
  ./tool/android/install-bundletool.sh
fi
BUNDLETOOL="java -jar $BUNDLETOOL_PATH"
VERSION_CODE=$($BUNDLETOOL dump manifest --bundle "$BUNDLE_FILE" --xpath /manifest/@android:versionCode)
debug_log "VERSION_CODE=$VERSION_CODE"
VERSION_NAME=$($BUNDLETOOL dump manifest --bundle "$BUNDLE_FILE" --xpath /manifest/@android:versionName)
debug_log "VERSION_NAME=$VERSION_NAME"

PUBLISH_TASK="publish${FLAVOR@u}ReleaseBundle"
debug_log "PUBLISH_TASK=$PUBLISH_TASK"

pushd android &> /dev/null

: ./gradlew "$PUBLISH_TASK" \
  --artifact-dir "$BUNDLE_FILE" \
  --release-name "$VERSION_CODE ($VERSION_NAME)"

popd &> /dev/null
