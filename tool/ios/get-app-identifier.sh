#!/usr/bin/env bash

set -e -o pipefail

source ./tool/constants.sh

FLAVOR_ENV=$(./tool/get-flavor-env.sh)

if [[ $FLAVOR_ENV == "prod" ]]; then
  echo "$APPLE_BUNDLE_ID"
elif [[ $FLAVOR_ENV == "stag" ]]; then
  echo "$APPLE_BUNDLE_ID.stag.release"
else
  echo "$APPLE_BUNDLE_ID.dev.release"
fi
