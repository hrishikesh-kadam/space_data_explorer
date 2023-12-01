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

IPA_FILE="./build/ios/ipa/$APP_NAME_KEBAB_CASE-$FLAVOR_ENV-release.ipa"
./tool/ios/generate-changelog.sh "$FLAVOR_ENV"
CHANGELOG_FILE="./ios/fastlane/$FLAVOR_ENV/metadata/en-US/release_notes.txt"
CHANGELOG_FILE_CONTENTS=$(< "$CHANGELOG_FILE")

pushd ios &> /dev/null
# Changelog / 'What to Test' is not working
bundle exec fastlane run upload_to_testflight \
  "${API_KEY_PATH_ARG[@]}" \
  ipa:".$IPA_FILE" \
  changelog:"$CHANGELOG_FILE_CONTENTS" \
  skip_waiting_for_build_processing:true
popd &> /dev/null
