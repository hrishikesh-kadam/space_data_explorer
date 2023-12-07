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
  echo "$APPLE_BUNDLE_ID_BASE"
elif [[ $FLAVOR_ENV == "stag" ]]; then
  echo "$APPLE_BUNDLE_ID_BASE.stag"
else
  echo "$APPLE_BUNDLE_ID_BASE.dev"
fi
