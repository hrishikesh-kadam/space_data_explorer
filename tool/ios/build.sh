#!/usr/bin/env bash

set -e -o pipefail

FLAVOR_ENV=$(./tool/get-flavor-env.sh)

EXPORT_ARG=(--no-codesign)
if [[ -s ./secrets/.git ]]; then
  ./tool/ios/install-profile.sh
  EXPORT_ARG=(--export-options-plist="./ios/config/$FLAVOR_ENV/ExportOptions.plist")
fi

flutter build ipa \
  --verbose \
  --flavor "$FLAVOR_ENV" \
  --dart-define="FLAVOR_ENV=$FLAVOR_ENV" \
  "${EXPORT_ARG[@]}"
