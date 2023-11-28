#!/usr/bin/env bash

set -e -o pipefail

source ./tool/constants.sh

API_KEY_PATH_ARG=()
if [[ -s ./secrets/.git ]]; then
  API_KEY_PATH_ARG=(--api_key_path "../secrets/ios/app-store-connect/fastlane-key.json")
fi

pushd ios &> /dev/null

APP_IDENTIFIERS=(
  "$APPLE_BUNDLE_ID.dev.release"
  # "$APPLE_BUNDLE_ID.stag.release"
  # "$APPLE_BUNDLE_ID"
)
FLAVOR_ENV=(
  "dev"
  # "stag"
  # "prod"
)

for i in "${!APP_IDENTIFIERS[@]}"; do

  bundle exec fastlane upload_to_app_store download_metadata \
    "${API_KEY_PATH_ARG[@]}" \
    --app_identifier "${APP_IDENTIFIERS[i]}" \
    --metadata_path "./fastlane/${FLAVOR_ENV[i]}/metadata" \
    --force

  # bundle exec fastlane upload_to_app_store download_screenshots \
  #   "${API_KEY_PATH_ARG[@]}" \
  #   --app_identifier "${APP_IDENTIFIERS[i]}" \
  #   --screenshots_path "./fastlane/${FLAVOR_ENV[i]}/screenshots" \
  #   --force

done

rm -rf ./fastlane/metadata ./fastlane/screenshots

popd &> /dev/null