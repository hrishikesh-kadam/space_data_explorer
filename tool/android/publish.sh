#!/usr/bin/env bash

set -e -o pipefail

FLAVOR_ENV=$(./tool/get-flavor-env.sh)

BUNDLE_FILE="./build/app/outputs/bundle/${FLAVOR_ENV}Release/app-${FLAVOR_ENV}-release.aab"

BUNDLETOOL_PATH="$ANDROID_HOME/bundletool-all.jar"
if [[ ! -s $BUNDLETOOL_PATH ]]; then
  ./tool/android/install-bundletool.sh
fi
BUNDLETOOL="java -jar $BUNDLETOOL_PATH"

VERSION_CODE=$( \
  $BUNDLETOOL dump manifest \
    --bundle "$BUNDLE_FILE" \
    --xpath /manifest/@android:versionCode
)
VERSION_NAME=$( \
  $BUNDLETOOL dump manifest \
    --bundle "$BUNDLE_FILE" \
    --xpath /manifest/@android:versionName
)

pushd android &> /dev/null
APPLICATION_ID=$(./gradlew -q getApplicationId -PvariantName="${FLAVOR_ENV}Release")
popd &> /dev/null

TRACK=$(./tool/android/get-track-from-flavor-env.sh "$FLAVOR_ENV")

./tool/android/generate-changelog.sh \
  "$FLAVOR_ENV" "$VERSION_CODE" "$VERSION_NAME"

pushd android &> /dev/null

bundle exec fastlane upload_to_play_store \
  --package_name "$APPLICATION_ID" \
  --version-name "$VERSION_CODE ($VERSION_NAME)" \
  --track "$TRACK" \
  --metadata_path "./fastlane/$FLAVOR_ENV/metadata/android" \
  --aab ".$BUNDLE_FILE"

popd &> /dev/null
