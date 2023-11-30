#!/usr/bin/env bash

# Arguments:
#   $1 FLAVOR_ENV dev / stag / prod.

set -e -o pipefail

FLAVOR_ENV=${1:-$(./tool/get-flavor-env.sh)}

./tool/ios/upload-metadata-screenshots.sh "$FLAVOR_ENV"

./tool/ios/upload-ipa.sh "$FLAVOR_ENV"

# if [[ $FLAVOR_ENV == "prod" ]]; then
#   ./tool/ios/submit-build.sh "$FLAVOR_ENV"
# fi
