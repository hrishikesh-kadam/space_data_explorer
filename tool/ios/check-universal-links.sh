#!/usr/bin/env bash

set -e -o pipefail

sudo swcutil verify \
  -d space-data-explorer-dev.web.app \
  -j ./assets/dev/.well-known/apple-app-site-association \
  -u https://space-data-explorer-dev.web.app

sudo swcutil verify \
  -d space-data-explorer-stag.web.app \
  -j ./assets/stag/.well-known/apple-app-site-association \
  -u https://space-data-explorer-stag.web.app

sudo swcutil verify \
  -d space-data-explorer.web.app \
  -j ./assets/prod/.well-known/apple-app-site-association \
  -u https://space-data-explorer.web.app
