#!/usr/bin/env bash

set -e -o pipefail

source ./tool/shell/set-logs-env.sh
source ./tool/shell/set-logs-env-bash.sh
PRINT_DEBUG_LOG=1
PRINT_INFO_LOG=1

./tool/check-line-endings.sh

./tool/shellcheck.sh

./tool/create.sh

./tool/format-analyze.sh

./tool/test.sh

./tool/web/build.sh

./tool/android/build.sh

git status -s
