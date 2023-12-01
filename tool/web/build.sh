#!/usr/bin/env bash

# Arguments:
#   $1 FLAVOR_ENV dev / stag / prod.

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

FLAVOR_ENV=${1:?\
$(print_in_red "Missing argument \$1 FLAVOR_ENV dev / stag / prod.")}

flutter build web \
  --dart-define="FLAVOR_ENV=$FLAVOR_ENV" \
  --source-maps

mkdir -p ./build/web/.well-known
cp "assets/digital-asset-links/$FLAVOR_ENV/assetlinks.json" \
  "build/web/.well-known/"
