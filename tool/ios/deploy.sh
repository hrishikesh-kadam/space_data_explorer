#!/usr/bin/env bash

set -e -o pipefail

FLAVOR_ENV=$(./tool/get-flavor-env.sh)

./tool/ios/upload-ipa.sh "$FLAVOR_ENV"
