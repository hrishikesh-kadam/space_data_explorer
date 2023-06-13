#!/usr/bin/env bash

set -e -o pipefail

source ./tool/shell/logs-env.sh

./tool/check-line-endings.sh

./tool/shell/shellcheck.sh

./tool/create.sh

./tool/format-analyze.sh

./tool/test.sh

./tool/web/build.sh

./tool/android/build.sh

git status -s
