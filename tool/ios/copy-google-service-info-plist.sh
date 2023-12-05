#!/usr/bin/env bash
# shellcheck disable=SC2317

set -e -o pipefail

# Not in use
# Used to see Debug View for Analytics, but couldn't succeed.
exit 0
FLAVOR_ENV="$(echo "$CONFIGURATION" | cut -d- -f2)"
cp "./config/$FLAVOR_ENV/GoogleService-Info.plist" \
  "$BUILT_PRODUCTS_DIR/$WRAPPER_NAME/"
