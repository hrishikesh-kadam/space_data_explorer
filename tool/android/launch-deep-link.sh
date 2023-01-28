#!/usr/bin/env bash

set -e -o pipefail

adb shell am start -a android.intent.action.VIEW \
  -c android.intent.category.BROWSABLE \
  -d "https://space-data-explorer.web.app/nasa-source/neows" \
  dev.hrishikesh_kadam.flutter.space_data_explorer
