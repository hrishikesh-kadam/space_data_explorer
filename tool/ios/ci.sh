#!/usr/bin/env bash

set -e -o pipefail

source ./tool/shell/logs-env.sh

./tool/check-line-endings.sh

./tool/shell/analyze.sh

./tool/create.sh

./tool/format-analyze.sh

# ./tool/test.sh

./tool/ios/build.sh

git status -s
