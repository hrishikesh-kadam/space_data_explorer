#!/usr/bin/env bash

set -e -o pipefail

if (( $(git status -s pubspec.yaml | wc -l) > 0 )); then
  PUBSPEC_MODIFIED=true
  git stash push -m "pubspec.yaml at $(date +"%d/%m/%Y %r")" pubspec.yaml
  git stash apply 0
fi

FLAVOR_ENV=$(./tool/get-flavor-env.sh)

AVD_NAMES=(
  "Pixel_6_API_34"
  # "Nexus_7_API_34"
  # "Nexus_10_API_34"
)
DEVICE_NAMES=(
  "pixel_6"
  # "Nexus 7 2013"
  # "Nexus 10"
)
IMAGE_NAME_SUFFIXES=(
  "_en-US"
  # "_en-US"
  # "_en-US"
)
GOLDEN_DIRECTORIES=(
  "android/fastlane/$FLAVOR_ENV/metadata/android/en-US/images/phoneScreenshots"
  # "android/fastlane/$FLAVOR_ENV/metadata/android/en-US/images/sevenInchScreenshots"
  # "android/fastlane/$FLAVOR_ENV/metadata/android/en-US/images/tenInchScreenshots"
)

for i in {0..0}; do

  ./tool/android/start-emulator.sh "${AVD_NAMES[i]}" "" "${DEVICE_NAMES[i]}"

  export GOLDEN_DIRECTORY="${GOLDEN_DIRECTORIES[i]}/"
  yq -i '.flutter.assets += [strenv(GOLDEN_DIRECTORY)]' pubspec.yaml

  flutter pub get

  # Flaky Test
  set +e +o pipefail
  flutter test \
    --flavor "$FLAVOR_ENV" \
    --dart-define="FLUTTER_TEST=true" \
    --dart-define="IMAGE_NAME_SUFFIX=${IMAGE_NAME_SUFFIXES[i]}" \
    --dart-define="GOLDEN_DIRECTORY=${GOLDEN_DIRECTORIES[i]}" \
    integration_test/golden_screenshots_test.dart
  set -e -o pipefail

  git restore pubspec.yaml
  if [[ $PUBSPEC_MODIFIED == true ]]; then
    git stash apply 0
  fi

  ./tool/android/kill-emulator.sh "${AVD_NAMES[i]}" || true

done
