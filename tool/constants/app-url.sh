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

if [[ $FLAVOR_ENV == "prod" ]]; then
  APP_URL="https://$APP_NAME_KEBAB_CASE.web.app"
elif [[ $FLAVOR_ENV == "dev" || $FLAVOR_ENV == "stag" ]]; then
  APP_URL="https://$APP_NAME_KEBAB_CASE-$FLAVOR_ENV.web.app"
else
  log_error_with_exit "Unknown argument FLAVOR_ENV=$FLAVOR_ENV"
fi

echo "$APP_URL"
