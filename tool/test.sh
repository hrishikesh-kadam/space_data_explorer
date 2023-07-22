#!/usr/bin/env bash

set -ex -o pipefail

rm -rf coverage

flutter test test/unit_test --coverage \
  --coverage-path coverage/unit_test_lcov.info
lcov --list coverage/unit_test_lcov.info

flutter test test/widget_test --coverage \
  --coverage-path coverage/widget_test_lcov.info
lcov --list coverage/widget_test_lcov.info

if [[ -s coverage/unit_test_lcov.info ]]; then
  lcov --add-tracefile coverage/unit_test_lcov.info \
    --add-tracefile coverage/widget_test_lcov.info \
    --output-file coverage/lcov.info
else
  cp coverage/widget_test_lcov.info coverage/lcov.info
fi
lcov --list coverage/lcov.info

./tool/coverage/check-coverage-ignored.sh

./tool/web/integration-test.sh

# if [[ ! $GITHUB_ACTIONS ]]; then
#   ./tool/android/test-golden-screenshots.sh
# fi
