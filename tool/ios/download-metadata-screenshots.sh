#!/usr/bin/env bash

# Arguments:
#   $1 FLAVOR_ENV dev / stag / prod.

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

FLAVOR_ENV=${1:?\
$(print_in_red "Missing argument \$1 FLAVOR_ENV dev / stag / prod.")}

API_KEY_PATH_ARG=()
if [[ -s ./secrets/.git ]]; then
  if [[ $GITHUB_ACTIONS == "true" ]]; then
    API_KEY_PATH_ARG=(--api_key_path "../secrets/ios/app-store-connect/non-interactive.json")
  else
    API_KEY_PATH_ARG=(--api_key_path "../secrets/ios/app-store-connect/interactive.json")
  fi
fi

BUNDLE_ID="$(./tool/ios/get-bundle-id.sh "$FLAVOR_ENV")"

pushd ios &> /dev/null

USE_LIVE_VERSION_ARG=()
if [[ $FLAVOR_ENV == "prod" ]]; then
  USE_LIVE_VERSION_ARG=(--use_live_version true)
fi

# Deliberately avoiding run keyword here, not working if present
bundle exec fastlane upload_to_app_store download_metadata \
  "${API_KEY_PATH_ARG[@]}" \
  --app_identifier "$BUNDLE_ID" \
  --metadata_path "./fastlane/$FLAVOR_ENV/metadata" \
  "${USE_LIVE_VERSION_ARG[@]}" \
  --force true

bundle exec fastlane upload_to_app_store download_screenshots \
  "${API_KEY_PATH_ARG[@]}" \
  --app_identifier "$BUNDLE_ID" \
  --screenshots_path "./fastlane/$FLAVOR_ENV/screenshots" \
  "${USE_LIVE_VERSION_ARG[@]}" \
  --force true

rm -rf ./fastlane/metadata ./fastlane/screenshots

popd &> /dev/null
