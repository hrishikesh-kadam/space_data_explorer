#!/usr/bin/env bash

# TODO(hrishikesh-kadam): Remove this once dev and stag review is completed
# Arguments:
#   $1 FLAVOR_ENV dev / stag / prod.

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

FLAVOR_ENV=${1:?\
$(print_in_red "Missing argument \$1 FLAVOR_ENV dev / stag / prod.")}

if [[ $FLAVOR_ENV == "stag" ]]; then
  RELEASE_STATUS="draft"
elif [[ $FLAVOR_ENV == "dev" || $FLAVOR_ENV == "prod" ]]; then
  RELEASE_STATUS="completed"
else
  log_error_with_exit "Unknown argument FLAVOR_ENV=$FLAVOR_ENV"
fi

echo "$RELEASE_STATUS"
