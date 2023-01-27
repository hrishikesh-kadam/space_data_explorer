#!/usr/bin/env bash

set -e

find ./tool -name "*.sh" \
  -exec shellcheck {} +
