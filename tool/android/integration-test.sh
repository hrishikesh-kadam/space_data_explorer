#!/usr/bin/env bash

set -e

source ./tool/android/start-emulator.sh

FLAVOR=$(./tool/android/get-flavor.sh)

# mapfile -t TARGET_PATHS < <(find integration_test -type f -name "*_test.dart")
TARGET_PATHS=(
  "integration_test/platform_specific_app_bar_test.dart"
)
for TARGET_PATH in "${TARGET_PATHS[@]}"; do
  flutter test \
    --flavor "$FLAVOR" \
    --dart-define="FLUTTER_TEST=true" \
    "$TARGET_PATH"
done

./tool/android/kill-emulator.sh
