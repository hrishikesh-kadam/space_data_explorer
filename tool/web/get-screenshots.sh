#!/usr/bin/env bash

set -e

chromedriver --port=4444 &
# mapfile -t TARGET_PATHS < <(find integration_test -type f -name "*_test.dart")
TARGET_PATHS=(
  "integration_test/get_screenshots_test.dart"
)
if [[ $CI ]] ; then
  DEVICE="web-server"
else
  DEVICE="chrome"
fi
for TARGET_PATH in "${TARGET_PATHS[@]}"; do
  flutter drive \
    --driver test_driver/screenshots_test.dart \
    --target "$TARGET_PATH" \
    -d $DEVICE
done
