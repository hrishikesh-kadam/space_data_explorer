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

if [[ -z $APPLICATION_ID ]]; then
  log_error_with_exit "Couldn't find applicationId for FLAVOR_ENV $FLAVOR_ENV"
else
  echo "$APPLICATION_ID"
fi
