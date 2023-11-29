#!/usr/bin/env bash

# References:
#   - https://docs.github.com/en/actions/deployment/deploying-xcode-applications/installing-an-apple-certificate-on-macos-runners-for-xcode-development
#   - https://github.com/Apple-Actions/import-codesign-certs/blob/master/src/security.ts

set -e -o pipefail

# shellcheck disable=SC1091
source ./secrets/ios/source.sh

security import "$APPLE_DIST_IDENTITY_PATH" \
  -k "$MAC_KEYCHAIN_PATH" \
  -f pkcs12 \
  -P "$APPLE_DIST_IDENTITY_PASSWORD" \
  -T /usr/bin/codesign

security set-key-partition-list \
  -S apple-tool:,apple: \
  -k "$MAC_KEYCHAIN_PASSWORD" \
  "$MAC_KEYCHAIN_PATH"

security find-identity -v -p codesigning
