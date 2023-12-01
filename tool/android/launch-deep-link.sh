#!/usr/bin/env bash

# Arguments:
#   $1 FLAVOR_ENV dev / stag / prod.

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

FLAVOR_ENV=${1:?\
$(print_in_red "Missing argument \$1 FLAVOR_ENV dev / stag / prod.")}

APP_URL=$(./tool/constants/app-url.sh)

pushd android &> /dev/null
APPLICATION_ID=$(./gradlew \
  -q :app:getApplicationId \
  -PvariantName="${FLAVOR_ENV}Debug")
popd &> /dev/null

adb shell am start -a android.intent.action.VIEW \
  -c android.intent.category.BROWSABLE \
  -d "$APP_URL/nasa/cad" \
  "$APPLICATION_ID"
