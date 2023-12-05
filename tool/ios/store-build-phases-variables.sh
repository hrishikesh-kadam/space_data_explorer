#!/usr/bin/env bash

set -e -o pipefail

OUTPUT_FILE="../build/ios/build-phases-variables.env"
{
  echo "# shellcheck shell=sh"
  echo "export PODS_ROOT=\"$PODS_ROOT\""
  echo "export DWARF_DSYM_FOLDER_PATH=\"$DWARF_DSYM_FOLDER_PATH\""
  echo "export DWARF_DSYM_FILE_NAME=\"$DWARF_DSYM_FILE_NAME\""
  echo "export SRCROOT=\"$SRCROOT\""
  echo "export BUILT_PRODUCTS_DIR=\"$BUILT_PRODUCTS_DIR\""
  echo "export INFOPLIST_PATH=\"$INFOPLIST_PATH\""
  echo "export CONFIGURATION=\"$CONFIGURATION\""
} > $OUTPUT_FILE
