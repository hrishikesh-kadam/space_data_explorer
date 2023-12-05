#!/usr/bin/env bash

# Arguments:
#   $1 FLAVOR_ENV dev / stag / prod.

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

FLAVOR_ENV=${1:?\
$(print_in_red "Missing argument \$1 FLAVOR_ENV dev / stag / prod.")}

source ./tool/constants.sh

BUNDLE_FILE="./build/app/outputs/bundle/${FLAVOR_ENV}Release/app-${FLAVOR_ENV}-release.aab"

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
APPLICATION_ID=$(./gradlew \
  -q :app:getApplicationId \
  -PvariantName="${FLAVOR_ENV}Release")
popd &> /dev/null

TRACK=$(./tool/android/get-track-from-flavor-env.sh "$FLAVOR_ENV")

./tool/android/generate-changelog.sh \
  "$FLAVOR_ENV" "$VERSION_CODE" "$VERSION_NAME"

pushd android &> /dev/null
bundle exec fastlane run upload_to_play_store \
  package_name:"$APPLICATION_ID" \
  version_name:"$VERSION_CODE ($VERSION_NAME)" \
  track:"$TRACK" \
  metadata_path:"./fastlane/$FLAVOR_ENV/metadata/android" \
  aab:".$BUNDLE_FILE"
popd &> /dev/null

FIREBASE_DART_FILE="lib/config/firebase/options/$FLAVOR_ENV.dart"
# shellcheck disable=SC2086
FIREBASE_APP_ID=$( \
  jq -r \
    '.flutter.platforms.dart."'$FIREBASE_DART_FILE'".configurations.android' \
    firebase.json
)

DEBUG_SYMBOL_PATH="build/app/outputs/bundle/${FLAVOR_ENV}Release/debug-info"

# source ./tool/firebase/source.sh "$FLAVOR_ENV"
firebase crashlytics:symbols:upload \
  --app "$FIREBASE_APP_ID" \
  "$DEBUG_SYMBOL_PATH"

# shellcheck disable=SC1091
source ./secrets/sentry/source.sh
sentry-cli debug-files upload \
  --include-sources \
  "$DEBUG_SYMBOL_PATH"
