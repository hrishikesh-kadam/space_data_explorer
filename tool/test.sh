#!/usr/bin/env bash

set -ex -o pipefail

rm -rf coverage

flutter test test/unit_test --coverage \
  --coverage-path coverage/unit_test_lcov.info
lcov --list coverage/unit_test_lcov.info \
  | grep -v ".*|.*100%.*|.*|"

if (( $(git status -s pubspec.yaml | wc -l) > 0 )); then
  PUBSPEC_MODIFIED=true
  git stash push -m "pubspec.yaml at $(date +"%d/%m/%Y %r")" pubspec.yaml
  git stash apply 0
fi

yq -i '.flutter.assets += [ "assets/fonts/Roboto/" ]' pubspec.yaml
yq -i '.flutter.assets += [ "assets/fonts/MaterialIcons/" ]' pubspec.yaml

flutter test test/widget_test --coverage \
  --coverage-path coverage/widget_test_lcov.info
lcov --list coverage/widget_test_lcov.info \
  | grep -v ".*|.*100%.*|.*|"

git restore pubspec.yaml
if [[ $PUBSPEC_MODIFIED == true ]]; then
  git stash apply 0
fi

if [[ -s coverage/unit_test_lcov.info ]]; then
  lcov --add-tracefile coverage/unit_test_lcov.info \
    --add-tracefile coverage/widget_test_lcov.info \
    --output-file coverage/lcov.info
else
  cp coverage/widget_test_lcov.info coverage/lcov.info
fi
lcov --list coverage/lcov.info \
  | grep -v ".*|.*100%.*|.*|"

./tool/coverage/check-coverage-ignored.sh

./tool/web/integration-test.sh

# if [[ ! $GITHUB_ACTIONS ]]; then
#   ./tool/android/test-golden-screenshots.sh
# fi
