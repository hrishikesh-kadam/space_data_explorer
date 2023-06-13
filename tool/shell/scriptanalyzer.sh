#!/usr/bin/env bash

set -e -o pipefail

echo "ScriptAnalyzer in process"

find ./tool -name "*.ps1" \
  -exec pwsh -NoProfile -Command Invoke-ScriptAnalyzer {} -EnableExit \;

print_in_green "ScriptAnalyzer completed"
