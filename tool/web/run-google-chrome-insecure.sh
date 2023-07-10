#!/usr/bin/env bash

set -e -o pipefail

: "${TMPDIR:=/tmp}"
USER_DATA_DIR="$TMPDIR/google-chrome-insecure"
mkdir -p "$USER_DATA_DIR"
google-chrome --disable-web-security --user-data-dir="$USER_DATA_DIR"
