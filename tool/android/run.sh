#!/usr/bin/env bash

set -e -o pipefail

ADB_DEVICES_OP_LINE_IGNORE=2
ADB_DEVICES_OP=$(adb devices | wc -l)
DEVICES_COUNT=$((ADB_DEVICES_OP - ADB_DEVICES_OP_LINE_IGNORE))

if ((DEVICES_COUNT <= 0)); then
  ./tool/android/start-emulator.sh
fi

FLAVOR_ENV=$(./tool/get-flavor-env.sh)
flutter run \
  --flavor "$FLAVOR_ENV" \
  --dart-define="FLAVOR_ENV=$FLAVOR_ENV"

./tool/android/kill-emulator.sh || true
