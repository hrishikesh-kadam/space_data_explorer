#!/usr/bin/env bash

set -e

./tool/analyze-test-format.sh

if [[ ! $GITHUB_ACTIONS == true ]]; then
  ./tool/android-gradle-checkAllVariants.sh
fi
