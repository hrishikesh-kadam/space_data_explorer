#!/usr/bin/env bash

set -e -o pipefail

chromedriver --port=4444 &
TARGET_PATHS=(
  "integration_test/platform_specific_app_bar_test.dart"
)
if [[ $GITHUB_ACTIONS == "true" ]] ; then
  DEVICE="web-server"
else
  DEVICE="chrome"
fi
for TARGET_PATH in "${TARGET_PATHS[@]}"; do
  flutter drive \
    --dart-define="FLUTTER_TEST=true" \
    --driver test_driver/integration_test.dart \
    --target "$TARGET_PATH" \
    -d $DEVICE
done
