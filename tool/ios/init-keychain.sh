#!/usr/bin/env bash

# References:
#   - https://docs.github.com/en/actions/deployment/deploying-xcode-applications/installing-an-apple-certificate-on-macos-runners-for-xcode-development
#   - https://github.com/Apple-Actions/import-codesign-certs/blob/master/src/security.ts

set -e -o pipefail

# shellcheck disable=SC1091
source ./secrets/ios/source.sh

if [[ -f "$MAC_KEYCHAIN_PATH" ]]; then
  security delete-keychain "$MAC_KEYCHAIN_PATH"
fi

security create-keychain -p "$MAC_KEYCHAIN_PASSWORD" "$MAC_KEYCHAIN_PATH"
security set-keychain-settings "$MAC_KEYCHAIN_PATH"
security unlock-keychain -p "$MAC_KEYCHAIN_PASSWORD" "$MAC_KEYCHAIN_PATH"
# shellcheck disable=SC2046
security list-keychains -d user \
  -s $(security list-keychains -d user | tr -d \") "$MAC_KEYCHAIN_PATH"
