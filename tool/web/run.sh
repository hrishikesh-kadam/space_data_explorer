#!/usr/bin/env bash

set -e -o pipefail

FLAVOR_ENV=$(./tool/get-flavor-env.sh)

flutter run -d chrome \
  --web-browser-flag="--disable-web-security" \
  --dart-define="FLAVOR_ENV=$FLAVOR_ENV"
