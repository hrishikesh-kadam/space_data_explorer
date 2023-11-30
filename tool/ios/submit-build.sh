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

bundle exec fastlane run upload_to_app_store \
  "${API_KEY_PATH_ARG[@]}" \
  app_identifier:"$APP_IDENTIFIER" \
  app_version:"$VERSION_MAJOR_MINOR_PATCH" \
  submit_for_review:true \
  automatic_release:true \
  skip_metadata:true \
  skip_screenshots:true \
  skip_binary_upload:true \
  precheck_include_in_app_purchases:false \
  force:true

popd &> /dev/null

# [!] Use of Advertising Identifier (IDFA) is required to submit
# Add information to the :submission_information option...
#   Docs: http://docs.fastlane.tools/actions/deliver/#compliance-and-idfa-settings
#   Example: submission_information: { add_id_info_uses_idfa: false }
#   Example: submission_information: {
#     add_id_info_uses_idfa: true,
#     add_id_info_serves_ads: false,
#     add_id_info_tracks_install: true,
#     add_id_info_tracks_action: true,
#     add_id_info_limits_tracking: true
#   }
#   Example CLI:
#     --submission_information "{\"add_id_info_uses_idfa\": false}"
