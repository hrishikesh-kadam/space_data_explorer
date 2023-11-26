#!/usr/bin/env bash

set -e -o pipefail

PROFILE_NAME="$(./tool/ios/get-profile-name.sh)"

API_KEY_PATH_ARG=()
if [[ -s ./secrets/.git ]]; then
  ./secrets/ios/private-keys/import.sh
  API_KEY_PATH_ARG=(--api_key_path "../secrets/ios/app-store-connect/fastlane-key.json")
fi

APP_IDENTIFIER="$(./tool/ios/get-app-identifier.sh)"

pushd ios &> /dev/null

if bundle exec fastlane get_provisioning_profile manage \
  | grep "$PROFILE_NAME" &> /dev/null; then
  echo "$PROFILE_NAME already installed locally"
else
  bundle exec fastlane get_provisioning_profile \
    "${API_KEY_PATH_ARG[@]}" \
    --readonly true \
    --provisioning_name "$PROFILE_NAME" \
    --app_identifier "$APP_IDENTIFIER" \
    --output-path "./fastlane/download"
fi

popd &> /dev/null
