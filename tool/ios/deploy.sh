#!/usr/bin/env bash

# Arguments:
#   $1 FLAVOR_ENV dev / stag / prod.

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

FLAVOR_ENV=${1:?\
$(print_in_red "Missing argument \$1 FLAVOR_ENV dev / stag / prod.")}

if [[ $FLAVOR_ENV == "prod" ]]; then
  ./tool/ios/upload-all.sh "$FLAVOR_ENV"
else
  ./tool/ios/upload-metadata-screenshots.sh "$FLAVOR_ENV"
  ./tool/ios/upload-ipa.sh "$FLAVOR_ENV"
fi
