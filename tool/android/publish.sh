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
source ./tool/firebase/source.sh
# shellcheck disable=SC1091
source ./secrets/sentry/source.sh

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

FIREBASE_APP_ID=$( \
  jq -r \
    .client[0].client_info.mobilesdk_app_id \
    "android/app/src/$FLAVOR_ENV/google-services.json"
)

_firebase crashlytics:symbols:upload \
  --app "$FIREBASE_APP_ID" \
  "build/app/outputs/bundle/${FLAVOR_ENV}Release/debug-info"

sentry-cli debug-files upload \
  --include-sources \
  "build/app/outputs/bundle/${FLAVOR_ENV}Release/debug-info"
