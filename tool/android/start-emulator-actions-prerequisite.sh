#!/usr/bin/env bash

set -e

if [[ $GITHUB_ACTIONS == "true" ]]; then
  if [[ $ANDROID_EMULATOR_ACTIONS_PREREQUISITE != "done" ]]; then
    PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
    PATH="$PATH:$ANDROID_SDK_ROOT/emulator"
    PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools"
    if [[ $RUNNER_OS == "Linux" ]]; then
      sudo apt-get install -y libpulse0
    fi
    echo "ANDROID_EMULATOR_ACTIONS_PREREQUISITE=done" >> "$GITHUB_ENV"
  fi
fi
