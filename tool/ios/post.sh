#!/usr/bin/env bash

set -e -o pipefail

if [[ $CI == "true" ]]; then
  security delete-keychain "$MAC_KEYCHAIN_PATH"
fi
