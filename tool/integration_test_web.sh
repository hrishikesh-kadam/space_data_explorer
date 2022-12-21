#!/usr/bin/env bash

chromedriver --port=4444 &
# mapfile -t TARGET_PATHS < <(find integration_test -type f -name "*_test.dart")
TARGET_PATHS=(
  "integration_test/web_platform_specific_app_bar_test.dart"
)
for TARGET_PATH in "${TARGET_PATHS[@]}"; do
  flutter drive \
    --driver test_driver/integration_test.dart \
    --target "$TARGET_PATH" \
    -d chrome
done
