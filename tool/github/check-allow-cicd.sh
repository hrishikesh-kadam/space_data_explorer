#!/usr/bin/env bash

set -e -o pipefail

if [[ $GITHUB_EVENT_NAME == "push" ]]; then
  ALLOW_CICD=true
elif [[ $GITHUB_EVENT_NAME == "pull_request" ]]; then
  # https://docs.github.com/en/webhooks-and-events/webhooks/webhook-events-and-payloads?actionType=opened#pull_request
  # https://docs.github.com/en/graphql/reference/enums#commentauthorassociation
  AUTHOR_ASSOCIATION=$(jq -r .pull_request.author_association "$GITHUB_EVENT_PATH")
  debug_log "AUTHOR_ASSOCIATION=$AUTHOR_ASSOCIATION"
  if [[ $AUTHOR_ASSOCIATION == "OWNER" \
          || $AUTHOR_ASSOCIATION == "MEMBER" ]]; then
    ALLOW_CICD=true
  fi
fi

echo "ALLOW_CICD=$ALLOW_CICD" >> "$GITHUB_OUTPUT"
