#!/usr/bin/env bash

set -e -o pipefail

# shellcheck disable=SC1091
source ./secrets/ios/source.sh

if [[ $CI == "true" ]]; then
  security delete-keychain "$MAC_KEYCHAIN_PATH"
fi
