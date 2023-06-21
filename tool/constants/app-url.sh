#!/usr/bin/env bash

set -e -o pipefail

source ./tool/constants.sh

FLAVOR_ENV=$(./tool/get-flavor-env.sh)

if [[ $FLAVOR_ENV == "prod" ]]; then
  APP_URL="https://$APP_NAME_KEBAB_CASE.web.app"
else
  APP_URL="https://$APP_NAME_KEBAB_CASE-$FLAVOR_ENV.web.app"
fi

echo "$APP_URL"
