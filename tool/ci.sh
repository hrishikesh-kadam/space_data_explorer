#!/usr/bin/env bash

set -e

./tool/create.sh

./tool/analyze-test-format.sh

./tool/web/build.sh

if [[ ! $CI == true ]]; then
  ./tool/android/android-gradle-checkAllVariants.sh
fi

./tool/android/build.sh
