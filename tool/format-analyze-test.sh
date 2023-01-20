#!/usr/bin/env bash

set -ex

flutter format --output none --set-exit-if-changed .

flutter pub run import_sorter:main --no-comments --exit-if-changed

flutter analyze

flutter test test/unit_test \
  --coverage --coverage-path "coverage/unit_test_lcov.info"
lcov --list coverage/unit_test_lcov.info

flutter test test/widget_test \
  --coverage --coverage-path "coverage/widget_test_lcov.info"
lcov --list coverage/widget_test_lcov.info

flutter test test/e2e_test \
  --coverage --coverage-path "coverage/e2e_test_lcov.info"
lcov --list coverage/e2e_test_lcov.info

lcov --add-tracefile "coverage/unit_test_lcov.info" \
  --add-tracefile "coverage/widget_test_lcov.info" \
  --add-tracefile "coverage/e2e_test_lcov.info" \
  --output-file "coverage/lcov.info"
lcov --list coverage/lcov.info

./tool/web/integration-test.sh
