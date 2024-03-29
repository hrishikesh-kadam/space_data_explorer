#!/usr/bin/env bash

# Not in use, Needs to be updated

set -e -o pipefail

if [[ $GITHUB_ACTIONS == "true" ]]; then
  if [[ $ANDROID_EMULATOR_ACTIONS_PREREQUISITE != "done" ]]; then
    PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
    PATH="$PATH:$ANDROID_HOME/emulator"
    PATH="$PATH:$ANDROID_HOME/platform-tools"
    if [[ $RUNNER_OS == "Linux" ]]; then
      sudo apt-get install -y libpulse0
    fi
    echo "ANDROID_EMULATOR_ACTIONS_PREREQUISITE=done" >> "$GITHUB_ENV"
  fi
fi
