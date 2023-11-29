#!/usr/bin/env bash

set -e -o pipefail

# shellcheck disable=SC1091
source ./secrets/ios/source.sh

if [[ $CI == "true" ]]; then
  security import "$APPLE_DIST_KEY_PATH" \
    -P "$APPLE_DIST_KEY_PASSWORD" \
    -A \
    -t cert \
    -f pkcs12 \
    -k "$MAC_KEYCHAIN_PATH"
else
  security import "$APPLE_DIST_KEY_PATH" \
    -P "$APPLE_DIST_KEY_PASSWORD"
fi
