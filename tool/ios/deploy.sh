#!/usr/bin/env bash

set -e -o pipefail

FLAVOR_ENV=$(./tool/get-flavor-env.sh)

./tool/ios/upload-metadata-screenshots.sh "$FLAVOR_ENV"

./tool/ios/upload-ipa.sh "$FLAVOR_ENV"

# if [[ $FLAVOR_ENV == "prod" ]]; then
#   ./tool/ios/submit-build.sh "$FLAVOR_ENV"
# fi
