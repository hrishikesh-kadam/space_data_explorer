#!/usr/bin/env bash

# Arguments:
#   $1 FLAVOR_ENV dev / stag / prod.

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

FLAVOR_ENV=${1:?\
$(print_in_red "Missing argument \$1 FLAVOR_ENV dev / stag / prod.")}

pushd android &> /dev/null
APPLICATION_ID=$(./gradlew \
  -q :app:getApplicationId \
  -PvariantName="${FLAVOR_ENV}Release")
popd &> /dev/null

TRACK=$(./tool/android/get-track-from-flavor-env.sh "$FLAVOR_ENV")

pushd android &> /dev/null
PLAY_VERSION_CODE=$(
  # Deliberately avoiding run keyword here, not working if present
  bundle exec fastlane get_play_version_code \
    package_name:"$APPLICATION_ID" \
    track:"$TRACK" \
    | grep --only-matching --extended-regexp "PLAY_VERSION_CODE=[0-9]+" \
    | cut -d = -f2
)
popd &> /dev/null

echo "$PLAY_VERSION_CODE"
