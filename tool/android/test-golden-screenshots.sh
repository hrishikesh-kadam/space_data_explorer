#!/usr/bin/env bash

set -e

source ./tool/android/start-emulator.sh

FLAVOR=$(./tool/android/get-flavor.sh)

if (( $(git status -s pubspec.yaml | wc -l) > 0 )); then
  PUBSPEC_MODIFIED=true
fi
git stash push -m "pubspec.yaml at $(date +"%d/%m/%Y %r")" pubspec.yaml

export GOLDEN_DIRECTORY="android/app/src/$FLAVOR/play/listings/en-US/graphics/phone-screenshots/"
yq -i '.flutter.assets += [strenv(GOLDEN_DIRECTORY)]' pubspec.yaml

flutter pub get

# Flaky Test
set +e
flutter test \
  --flavor "$FLAVOR" \
  --dart-define="FLUTTER_TEST=true" \
  --dart-define="FLAVOR=$FLAVOR" \
  integration_test/golden_screenshots_test.dart
set -e

git restore pubspec.yaml
if [[ $PUBSPEC_MODIFIED == true ]]; then
  git stash apply 0
fi

./tool/android/kill-emulator.sh
