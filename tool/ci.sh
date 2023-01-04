#!/usr/bin/env bash

set -e

./tool/analyze-test-format.sh

if [[ ! $CI == true ]]; then
  ./tool/android-gradle-checkAllVariants.sh
fi
