#!/usr/bin/env bash

set -e -o pipefail

source ./tool/constants.sh

FLAVOR_ENV=$(./tool/get-flavor-env.sh)

if [[ $FLAVOR_ENV == "prod" ]]; then
  echo "$APP_NAME Prod Release Profile"
elif [[ $FLAVOR_ENV == "stag" ]]; then
  echo "$APP_NAME Stag Release Profile"
else
  echo "$APP_NAME Dev Release Profile"
fi
