#!/usr/bin/env bash

set -e -o pipefail

CURRENT_IGNORED=$(
  git grep \
    --line-number \
    --extended-regexp "coverage:ignore-(line|start|file)" \
    -- *.dart ':(exclude)*.g.dart' \
    | awk -F: '{ print $1":"$2 }' \
    || true
)
CHECKED_IGNORED=./tool/coverage/coverage-ignored.txt
diff --unified --color --strip-trailing-cr --ignore-blank-lines \
  $CHECKED_IGNORED <(echo "$CURRENT_IGNORED")
