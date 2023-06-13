#!/usr/bin/env bash

set -e -o pipefail

source ./tool/shell/logs-env.sh

if [[ $(uname -s) =~ ^"MINGW" ]]; then
  ./tool/check-line-endings.sh
fi

./tool/shell/analyze.sh

./tool/create.sh

./tool/format-analyze.sh

./tool/test.sh

./tool/web/build.sh

./tool/android/build.sh

git status -s
