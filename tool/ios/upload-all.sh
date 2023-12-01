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
IPA_FILE="./build/ios/ipa/$APP_NAME_KEBAB_CASE-$FLAVOR_ENV-release.ipa"
./tool/ios/generate-changelog.sh "$FLAVOR_ENV"
SUBMISSION_INFORMATION=$(< "./ios/fastlane/$FLAVOR_ENV/submission-information.json")

pushd ios &> /dev/null
bundle exec fastlane run upload_to_app_store \
  "${API_KEY_PATH_ARG[@]}" \
  app_identifier:"$APP_IDENTIFIER" \
  app_version:"$VERSION_MAJOR_MINOR_PATCH" \
  ipa:".$IPA_FILE" \
  metadata_path:"./fastlane/$FLAVOR_ENV/metadata" \
  screenshots_path:"./fastlane/$FLAVOR_ENV/screenshots" \
  overwrite_screenshots:true \
  submit_for_review:true \
  automatic_release:true \
  precheck_include_in_app_purchases:false \
  submission_information:"$SUBMISSION_INFORMATION" \
  force:true
popd &> /dev/null