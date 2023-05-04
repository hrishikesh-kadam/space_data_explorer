#!/usr/bin/env bash

# $1 FLAVOR_ENV dev, stag, prod.

set -e -o pipefail

source ./tool/set-logs-env.sh

FLAVOR_ENV=$1

if [[ $FLAVOR_ENV == "dev" || $FLAVOR_ENV == "stag" ]]; then
  TRACK="internal"
elif [[ $FLAVOR_ENV == "prod" ]]; then
  TRACK="production"
else
  error_log_with_exit "Unknown FLAVOR_ENV=$FLAVOR_ENV" 1
fi

echo "$TRACK"
