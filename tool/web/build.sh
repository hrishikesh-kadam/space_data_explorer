#!/usr/bin/env bash

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

flutter build web --release

mkdir -p ./build/web/.well-known
FLAVOR_ENV=$(./tool/get-flavor-env.sh)
cp "assets/digital-asset-links/$FLAVOR_ENV/assetlinks.json" "build/web/.well-known/"
