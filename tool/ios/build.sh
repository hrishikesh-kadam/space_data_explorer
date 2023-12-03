#!/usr/bin/env bash

# Arguments:
#   $1 FLAVOR_ENV dev / stag / prod.

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

FLAVOR_ENV=${1:?\
$(print_in_red "Missing argument \$1 FLAVOR_ENV dev / stag / prod.")}

source ./tool/constants.sh

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
  # --split-debug-info \
  # --obfuscate

# TODO(hrishikesh-kadam): Check this once again some other day.
# Stack traces seen on the Crashlytics web portal are obfuscated when above 
# flags are used.
# Tested on Flutter v3.16.2 stable.
# References:
# 1. https://docs.flutter.dev/deployment/obfuscate
# 2. https://github.com/flutter/flutter/issues/124715
# 3. https://github.com/dart-lang/sdk/commit/ecf19681223ca9c5daf8ba4f4d3a0d9b91efd956
