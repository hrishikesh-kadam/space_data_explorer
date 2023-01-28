#!/usr/bin/env bash

set -e -o pipefail

find ./tool -name "*.sh" \
  -exec shellcheck {} +
