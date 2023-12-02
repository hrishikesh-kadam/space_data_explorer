#!/usr/bin/env bash

# Arguments:
#   $1 FLAVOR_ENV dev / stag / prod.

# References:
#   - https://docs.flutter.dev/cookbook/navigation/set-up-universal-links
#   - https://developer.apple.com/documentation/xcode/supporting-associated-domains
#   - https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_associated-domains#discussion
#   - https://developer.apple.com/documentation/bundleresources/applinks/details/components
#   - https://developer.apple.com/documentation/technotes/tn3155-debugging-universal-links

# Notes:
#   - Verified by adding ?mode=developer in the ./ios/Runner/dev.entitlements file.
#   - TODO(hrishikesh-kadam): Yet to verify on the actual device.

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

FLAVOR_ENV=${1:?\
$(print_in_red "Missing argument \$1 FLAVOR_ENV dev / stag / prod.")}

APP_URL=$(./tool/constants/app-url.sh "$FLAVOR_ENV")

xcrun simctl openurl booted "$APP_URL/nasa/cad"
