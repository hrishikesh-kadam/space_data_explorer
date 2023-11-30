#!/usr/bin/env bash

# Arguments:
#   $1 FLAVOR_ENV dev / stag / prod.

set -e -o pipefail

source ./tool/constants.sh

FLAVOR_ENV=${1:?"Missing argument \$1 FLAVOR_ENV dev / stag / prod."}

if [[ $FLAVOR_ENV == "prod" ]]; then
  echo "$APP_NAME Prod Release Profile"
elif [[ $FLAVOR_ENV == "stag" ]]; then
  echo "$APP_NAME Stag Release Profile"
else
  echo "$APP_NAME Dev Release Profile"
fi
