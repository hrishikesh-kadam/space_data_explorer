#!/usr/bin/env bash

set -e -o pipefail

source ./tool/shell/logs-env.sh

./tool/check-line-endings.sh

./tool/shell/analyze.sh

./tool/create.sh

./tool/format-analyze.sh

./tool/test.sh

./tool/web/build.sh

./tool/android/build.sh

if [[ $(uname -s) =~ ^"Darwin" ]]; then
  FLAVOR_ENV=$(./tool/get-flavor-env.sh)
  ./tool/ios/build.sh "$FLAVOR_ENV"
fi

git status -s
