#!/usr/bin/env bash

set -e

./tool/analyze-test-format.sh

if [[ ! $CI == true ]]; then
  ./tool/android/android-gradle-checkAllVariants.sh
fi
