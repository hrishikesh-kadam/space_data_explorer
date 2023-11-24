#!/usr/bin/env bash

set -e -o pipefail

FLAVOR_ENV=$(./tool/get-flavor-env.sh)

flutter build ipa \
  --flavor "$FLAVOR_ENV" \
  --dart-define="FLAVOR_ENV=$FLAVOR_ENV" \
  --export-options-plist="./ios/config/$FLAVOR_ENV/ExportOptions.plist"
