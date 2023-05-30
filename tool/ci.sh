#!/usr/bin/env bash

set -e -o pipefail

./tool/shellcheck.sh

./tool/create.sh

./tool/format-analyze.sh

./tool/test.sh

./tool/web/build.sh

./tool/android/build.sh

git status -s
