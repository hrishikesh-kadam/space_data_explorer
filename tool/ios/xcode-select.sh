#!/usr/bin/env bash

# To prefer latest Xcode in GitHub Actions Workflow

set -e -o pipefail

XCODE_PATHS=(
  "/Applications/Xcode_15.0.1.app/Contents/Developer"
)

for i in "${!XCODE_PATHS[@]}"; do
  if [[ -r ${XCODE_PATHS[i]} \
    && $(xcode-select --print-path) != "${XCODE_PATHS[i]}" ]]; then
    sudo xcode-select --switch "${XCODE_PATHS[i]}"
    xcode-select --print-path
    exit
  fi
done
