#!/usr/bin/env bash

# Arguments:
#   $1 FLAVOR_ENV dev / stag / prod.

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

FLAVOR_ENV=${1:?\
$(print_in_red "Missing argument \$1 FLAVOR_ENV dev / stag / prod.")}

PROFILE_NAME="$(./tool/ios/get-profile-name.sh "$FLAVOR_ENV")"

API_KEY_PATH_ARG=()
if [[ -s ./secrets/.git ]]; then
  ./tool/ios/import-identity.sh
  if [[ $GITHUB_ACTIONS == "true" ]]; then
    API_KEY_PATH_ARG=(api_key_path:"../secrets/ios/app-store-connect/non-interactive.json")
  else
    API_KEY_PATH_ARG=(api_key_path:"../secrets/ios/app-store-connect/interactive.json")
  fi
fi

APP_IDENTIFIER="$(./tool/ios/get-app-identifier.sh "$FLAVOR_ENV")"

pushd ios &> /dev/null

# Deliberately avoiding run keyword here, not working if present
if bundle exec fastlane get_provisioning_profile manage \
  | grep "$PROFILE_NAME" &> /dev/null; then
  echo "$PROFILE_NAME already present."
else
  bundle exec fastlane run get_provisioning_profile \
    "${API_KEY_PATH_ARG[@]}" \
    readonly:"true" \
    provisioning_name:"$PROFILE_NAME" \
    app_identifier:"$APP_IDENTIFIER" \
    output_path:"./fastlane/download"
fi

popd &> /dev/null
