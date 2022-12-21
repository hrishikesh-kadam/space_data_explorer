#!/usr/bin/env bash

TARGET_PATHS=(
  "integration_test/web_platform_specific_app_bar_test.dart"
)
for TARGET_PATH in "${TARGET_PATHS[@]}"; do
  (
    flutter run "$TARGET_PATH" \
      --vmservice-out-file=coverage/vm-service-url.txt \
      -d chrome &
    sleep 35
    dart pub global run coverage:collect_coverage \
      --uri="$(cat coverage/vm-service-url.txt)" \
      --out coverage/coverage.json
  )
done
