#!/usr/bin/env bash

# Arguments:
#   $1 FLAVOR_ENV dev / stag / prod.

set -e -o pipefail

source ./tool/constants.sh

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

FLAVOR_ENV=${1:?\
$(print_in_red "Missing argument \$1 FLAVOR_ENV dev / stag / prod.")}

if [[ $FLAVOR_ENV == "prod" ]]; then
  echo "$APP_NAME Prod Release Profile"
elif [[ $FLAVOR_ENV == "stag" ]]; then
  echo "$APP_NAME Stag Release Profile"
else
  echo "$APP_NAME Dev Release Profile"
fi
