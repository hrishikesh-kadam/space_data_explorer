#!/usr/bin/env bash

set -e -o pipefail

if [[ $CI == "true" ]]; then
  security list-keychains
  echo ""
  security list-keychains -d user
  ./tool/ios/init-keychain.sh
fi
