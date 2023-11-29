#!/usr/bin/env bash

set -e -o pipefail

if [[ $CI == "true" ]]; then
  ./tool/ios/init-keychain.sh
fi
