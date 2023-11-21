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

  bundle exec fastlane upload_to_app_store \
    --app_identifier "${APP_IDENTIFIERS[i]}" \
    --metadata_path "./fastlane/${FLAVOR_ENV[i]}/metadata" \
    --screenshots_path "./fastlane/${FLAVOR_ENV[i]}/screenshots" \
    --overwrite_screenshots true \
    --run_precheck_before_submit false \
    --force

done

popd &> /dev/null
