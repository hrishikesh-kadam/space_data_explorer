#!/usr/bin/env bash

set -e -o pipefail

chromedriver --port=4444 &
# mapfile -t TARGET_PATHS < <(find integration_test -type f -name "*_test.dart")
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
    --driver test_driver/integration_test.dart \
    --target "$TARGET_PATH" \
    -d $DEVICE
done
