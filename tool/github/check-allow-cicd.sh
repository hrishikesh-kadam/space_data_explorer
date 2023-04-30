#!/usr/bin/env bash

set -e -o pipefail

source ./tool/set-logs-env.sh
PRINT_DEBUG_LOG=1

if [[ $GITHUB_TRIGGERING_ACTOR != "dependabot[bot]" ]]; then
  ALLOW_CICD=true
elif [[ $GITHUB_EVENT_NAME == "pull_request" ]]; then
  AUTHOR_ASSOCIATION=$(jq .pull_request.author_association "$GITHUB_EVENT_PATH")
  debug_log "AUTHOR_ASSOCIATION=$AUTHOR_ASSOCIATION"
  if [[ $AUTHOR_ASSOCIATION == "OWNER" \
          || $AUTHOR_ASSOCIATION == "MEMBER" ]]; then
    ALLOW_CICD=true
  fi
fi

echo "ALLOW_CICD=$ALLOW_CICD" >> "$GITHUB_OUTPUT"
