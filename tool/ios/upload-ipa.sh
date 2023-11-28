#!/usr/bin/env bash

set -e -o pipefail

FLAVOR_ENV=${1:?"Missing argument \$1 FLAVOR_ENV"}

source ./tool/constants.sh

API_KEY_PATH_ARG=()
if [[ -s ./secrets/.git ]]; then
  API_KEY_PATH_ARG=(api_key_path:"../secrets/ios/app-store-connect/fastlane-key.json")
fi

IPA_FILE="./build/ios/ipa/$APP_NAME_KEBAB_CASE-$FLAVOR_ENV-release.ipa"

pushd ios &> /dev/null
bundle exec fastlane run upload_to_testflight \
  "${API_KEY_PATH_ARG[@]}" \
  skip_waiting_for_build_processing:"true" \
  ipa:".$IPA_FILE"
popd &> /dev/null