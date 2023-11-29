#!/usr/bin/env bash

# References:
#   - https://docs.github.com/en/actions/deployment/deploying-xcode-applications/installing-an-apple-certificate-on-macos-runners-for-xcode-development

set -e -o pipefail

# shellcheck disable=SC1091
source ./secrets/ios/source.sh

if [[ -s "$MAC_KEYCHAIN_PATH" ]]; then
  security delete-keychain "$MAC_KEYCHAIN_PATH"
fi

security create-keychain -p "$MAC_KEYCHAIN_PASSWORD" "$MAC_KEYCHAIN_PATH"
security set-keychain-settings -lut 21600 "$MAC_KEYCHAIN_PATH"
security unlock-keychain -p "$MAC_KEYCHAIN_PASSWORD" "$MAC_KEYCHAIN_PATH"
security list-keychains -d user -s "$MAC_KEYCHAIN_PATH"
