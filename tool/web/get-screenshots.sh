#!/usr/bin/env bash

set -e -o pipefail

FLAVOR_ENV=$(./tool/get-flavor-env.sh)

chromedriver --port=4444 &
# mapfile -t TARGET_PATHS < <(find integration_test -type f -name "*_test.dart")
TARGET_PATHS=(
  "integration_test/get_screenshots_test.dart"
)
if [[ $GITHUB_ACTIONS == "true" ]] ; then
  DEVICE="web-server"
else
  DEVICE="chrome"
fi
for TARGET_PATH in "${TARGET_PATHS[@]}"; do
  flutter drive \
    --driver test_driver/screenshots_test.dart \
    --target "$TARGET_PATH" \
    --dart-define="FLAVOR_ENV=$FLAVOR_ENV" \
    -d $DEVICE
done
