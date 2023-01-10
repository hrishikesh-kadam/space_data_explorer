#!/usr/bin/env bash

set -e

source "./tool/set-logs-env.sh"
PRINT_DEBUG_LOG=1

pushd android &> /dev/null

BRANCH="$(git rev-parse --abbrev-ref HEAD)"
if [[ $BRANCH != "prod" && \
  $BRANCH != "stag" && \
  $BRANCH != "dev" ]]; then
  FLAVOR="dev"
else
  FLAVOR=$BRANCH
fi

BUNDLE_FILE="../build/app/outputs/bundle/${FLAVOR}Release/app-${FLAVOR}-release.aab"

BUNDLETOOL="java -jar $ANDROID_SDK_ROOT/bundletool-all.jar"
VERSION_CODE=$($BUNDLETOOL dump manifest --bundle "$BUNDLE_FILE" --xpath /manifest/@android:versionCode)
debug_log "VERSION_CODE=$VERSION_CODE"
VERSION_NAME=$($BUNDLETOOL dump manifest --bundle "$BUNDLE_FILE" --xpath /manifest/@android:versionName)
debug_log "VERSION_NAME=$VERSION_NAME"

PUBLISH_TASK="publish${FLAVOR@u}ReleaseBundle"
debug_log "PUBLISH_TASK=$PUBLISH_TASK"

./gradlew "$PUBLISH_TASK" \
  --artifact-dir "$BUNDLE_FILE" \
  --release-name "$VERSION_CODE ($VERSION_NAME)"

popd &> /dev/null
