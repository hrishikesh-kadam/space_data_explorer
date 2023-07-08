#!/usr/bin/env bash

set -e -o pipefail

flutter run -d chrome --web-browser-flag="--disable-web-security"
