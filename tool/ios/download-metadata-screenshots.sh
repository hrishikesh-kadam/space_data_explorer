#!/usr/bin/env bash

# Arguments:
#   $1 FLAVOR_ENV dev / stag / prod.

set -e -o pipefail

FLAVOR_ENV=${1:?"Missing argument \$1 FLAVOR_ENV dev / stag / prod."}

API_KEY_PATH_ARG=()
if [[ -s ./secrets/.git ]]; then
  if [[ $GITHUB_ACTIONS == "true" ]]; then
    API_KEY_PATH_ARG=(--api_key_path "../secrets/ios/app-store-connect/non-interactive.json")
  else
    API_KEY_PATH_ARG=(--api_key_path "../secrets/ios/app-store-connect/interactive.json")
  fi
fi

APP_IDENTIFIER="$(./tool/ios/get-app-identifier.sh "$FLAVOR_ENV")"

pushd ios &> /dev/null

USE_LIVE_VERSION_ARG=()
if [[ $FLAVOR_ENV == "prod" ]]; then
  USE_LIVE_VERSION_ARG=(--use_live_version true)
fi

bundle exec fastlane upload_to_app_store download_metadata \
  "${API_KEY_PATH_ARG[@]}" \
  --app_identifier "$APP_IDENTIFIER" \
  --metadata_path "./fastlane/$FLAVOR_ENV/metadata" \
  "${USE_LIVE_VERSION_ARG[@]}" \
  --force true

bundle exec fastlane upload_to_app_store download_screenshots \
  "${API_KEY_PATH_ARG[@]}" \
  --app_identifier "$APP_IDENTIFIER" \
  --screenshots_path "./fastlane/$FLAVOR_ENV/screenshots" \
  "${USE_LIVE_VERSION_ARG[@]}" \
  --force true

rm -rf ./fastlane/metadata ./fastlane/screenshots

popd &> /dev/null
