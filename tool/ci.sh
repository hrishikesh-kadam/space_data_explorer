#!/usr/bin/env bash

set -e -o pipefail

./tool/shellcheck.sh

./tool/create.sh

./tool/format-analyze-test.sh

./tool/web/build.sh

# TODO(hrishikesh-kadam): Uncomment this LABEL:contri
# ./tool/android/build.sh
