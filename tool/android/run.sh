#!/usr/bin/env bash

set -e -o pipefail

./tool/android/start-emulator.sh

FLAVOR_ENV=$(./tool/get-flavor-env.sh)
flutter run --flavor "$FLAVOR_ENV"

./tool/android/kill-emulator.sh
