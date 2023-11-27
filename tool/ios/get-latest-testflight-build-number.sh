#!/usr/bin/env bash

# $1 FLAVOR_ENV dev, stag, prod.

set -e -o pipefail

FLAVOR_ENV=${1:?"Missing argument \$1 FLAVOR_ENV"}

source ./tool/constants.sh

API_KEY_PATH_ARG=()
if [[ -s ./secrets/.git ]]; then
  API_KEY_PATH_ARG=(api_key_path:"../secrets/ios/app-store-connect/fastlane-key.json")
fi

APP_IDENTIFIER="$(./tool/ios/get-app-identifier.sh "$FLAVOR_ENV")"

pushd ios &> /dev/null
TESTFLIGHT_BUILD_NUMBER=$(
  bundle exec fastlane run latest_testflight_build_number \
  "${API_KEY_PATH_ARG[@]}" \
  app_identifier:"$APP_IDENTIFIER" \
  version:"$VERSION_MAJOR_MINOR_PATCH" \
  | grep --only-matching --extended-regexp "Result: [0-9]+" \
  | cut -d ' ' -f2
)
popd &> /dev/null

echo "$TESTFLIGHT_BUILD_NUMBER"
