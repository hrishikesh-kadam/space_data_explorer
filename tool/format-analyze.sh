#!/usr/bin/env bash

set -ex -o pipefail

dart format --output none --set-exit-if-changed .

dart run import_sorter:main --exit-if-changed

flutter analyze
