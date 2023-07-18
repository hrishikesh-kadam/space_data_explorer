#!/usr/bin/env bash

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

echo "Checking CR line endings in git tracked files"
output=$( \
  git ls-files \
    --full-name \
    --recurse-submodules \
    -z \
    | xargs -0 \
        mac2unix \
          --info=chdumbt \
)
if [[ $output ]]; then
  log_error "Found CR line ending File(s)"
  print_in_red "$output"
  exit 1
else
  print_in_green "Checked CR line endings in git tracked files"
fi

echo "Checking CRLF line endings in git tracked files"
output=$( \
  git ls-files \
    --full-name \
    --recurse-submodules \
    -z \
    | xargs -0 \
        dos2unix \
          --info=chdumbt \
)
if [[ $output ]]; then
  log_error "Found CRLF line ending File(s)"
  print_in_red "$output"
  exit 1
else
  print_in_green "Checked CRLF line endings in git tracked files"
fi
