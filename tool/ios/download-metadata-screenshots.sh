#!/usr/bin/env bash

set -e -o pipefail

source ./secrets/ios/source.sh
source ./tool/constants.sh

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

  bundle exec fastlane deliver download_metadata \
    --app_identifier "${APP_IDENTIFIERS[i]}" \
    --metadata_path "./fastlane/${FLAVOR_ENV[i]}/metadata" \
    --force

  bundle exec fastlane deliver download_screenshots \
    --app_identifier "${APP_IDENTIFIERS[i]}" \
    --screenshots_path "./fastlane/${FLAVOR_ENV[i]}/screenshots" \
    --force

done

rm -rf ./fastlane/metadata ./fastlane/screenshots

popd &> /dev/null
