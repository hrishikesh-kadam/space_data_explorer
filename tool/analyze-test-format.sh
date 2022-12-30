#!/usr/bin/env bash

set -ex

flutter pub get
dart analyze

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

./tool/integration_test_web.sh

dart format --output none --set-exit-if-changed .
