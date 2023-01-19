#!/usr/bin/env bash

set -e

./tool/create.sh

./tool/analyze-test-format.sh

./tool/web/build.sh

./tool/android/build.sh
