#!/usr/bin/env bash

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

FLAVOR_ENV=$(./tool/get-flavor-env.sh)

flutter build web \
  --dart-define="FLAVOR_ENV=$FLAVOR_ENV" \
  --source-maps

mkdir -p ./build/web/.well-known
cp "assets/digital-asset-links/$FLAVOR_ENV/assetlinks.json" "build/web/.well-known/"
