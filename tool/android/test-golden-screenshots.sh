#!/usr/bin/env bash

set -e -o pipefail

source ./tool/android/start-emulator.sh

FLAVOR_ENV=$(./tool/get-flavor-env.sh)

if (( $(git status -s pubspec.yaml | wc -l) > 0 )); then
  PUBSPEC_MODIFIED=true
fi
git stash push -m "pubspec.yaml at $(date +"%d/%m/%Y %r")" pubspec.yaml

export GOLDEN_DIRECTORY="android/app/src/$FLAVOR_ENV/play/listings/en-US/graphics/phone-screenshots/"
yq -i '.flutter.assets += [strenv(GOLDEN_DIRECTORY)]' pubspec.yaml

flutter pub get

# Flaky Test
set +e +o pipefail
flutter test \
  --flavor "$FLAVOR_ENV" \
  --dart-define="FLUTTER_TEST=true" \
  --dart-define="FLAVOR_ENV=$FLAVOR_ENV" \
  integration_test/golden_screenshots_test.dart
set -e -o pipefail

git restore pubspec.yaml
if [[ $PUBSPEC_MODIFIED == true ]]; then
  git stash apply 0
fi

./tool/android/kill-emulator.sh
