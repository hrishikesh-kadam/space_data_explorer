#!/usr/bin/env bash

set -e -o pipefail

./tool/android/start-emulator.sh

FLAVOR_ENV=$(./tool/get-flavor-env.sh)

# mapfile -t TARGET_PATHS < <(find integration_test -type f -name "*_test.dart")
TARGET_PATHS=(
  "integration_test/platform_specific_app_bar_test.dart"
)
for TARGET_PATH in "${TARGET_PATHS[@]}"; do
  flutter test \
    --flavor "$FLAVOR_ENV" \
    --dart-define="FLUTTER_TEST=true" \
    "$TARGET_PATH"
done

./tool/android/kill-emulator.sh || true
