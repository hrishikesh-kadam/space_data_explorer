#!/usr/bin/env bash

# Arguments:
#   $1 FLAVOR_ENV dev / stag / prod.

set -e -o pipefail

FLAVOR_ENV=${1:?"Missing argument \$1 FLAVOR_ENV dev / stag / prod."}

if [[ $FLAVOR_ENV == "dev" || $FLAVOR_ENV == "stag" ]]; then
  TRACK="internal"
elif [[ $FLAVOR_ENV == "prod" ]]; then
  TRACK="production"
else
  echo "Error: Unknown argument FLAVOR_ENV=$FLAVOR_ENV"
  exit 1
fi

echo "$TRACK"
