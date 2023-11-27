#!/usr/bin/env bash

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

FLAVOR_ENV=$(./tool/get-flavor-env.sh)

if [[ -s ./secrets/.git ]]; then
  TESTFLIGHT_BUILD_NUMBER=$(./tool/ios/get-latest-testflight-build-number.sh "$FLAVOR_ENV")
  log_info "TESTFLIGHT_BUILD_NUMBER=$TESTFLIGHT_BUILD_NUMBER"
  INCREMENTED_BUILD_NUMBER=$(( TESTFLIGHT_BUILD_NUMBER+1 ))
  log_info "INCREMENTED_BUILD_NUMBER=$INCREMENTED_BUILD_NUMBER"
else
  INCREMENTED_BUILD_NUMBER=1
fi

EXPORT_ARG=(--no-codesign)
if [[ -s ./secrets/.git ]]; then
  ./tool/ios/install-profile.sh "$FLAVOR_ENV"
  EXPORT_ARG=(--export-options-plist="./ios/config/$FLAVOR_ENV/ExportOptions.plist")
fi

flutter build ipa \
  --flavor "$FLAVOR_ENV" \
  --dart-define="FLAVOR_ENV=$FLAVOR_ENV" \
  --build-number "$INCREMENTED_BUILD_NUMBER" \
  "${EXPORT_ARG[@]}"
