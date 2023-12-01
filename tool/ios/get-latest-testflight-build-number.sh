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

API_KEY_PATH_ARG=()
if [[ -s ./secrets/.git ]]; then
  if [[ $GITHUB_ACTIONS == "true" ]]; then
    API_KEY_PATH_ARG=(api_key_path:"../secrets/ios/app-store-connect/non-interactive.json")
  else
    API_KEY_PATH_ARG=(api_key_path:"../secrets/ios/app-store-connect/interactive.json")
  fi
fi

APP_IDENTIFIER="$(./tool/ios/get-app-identifier.sh "$FLAVOR_ENV")"

pushd ios &> /dev/null
TESTFLIGHT_BUILD_NUMBER=$(
  bundle exec fastlane run latest_testflight_build_number \
  "${API_KEY_PATH_ARG[@]}" \
  app_identifier:"$APP_IDENTIFIER" \
  version:"$VERSION_MAJOR_MINOR_PATCH" \
  initial_build_number:0 \
  | grep --only-matching --extended-regexp "Result: [0-9]+" \
  | cut -d ' ' -f2
)
popd &> /dev/null

echo "$TESTFLIGHT_BUILD_NUMBER"
