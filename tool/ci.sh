#!/usr/bin/env bash

set -e

./tool/shellcheck.sh

./tool/create.sh

./tool/format-analyze-test.sh

./tool/web/build.sh

./tool/android/build.sh
