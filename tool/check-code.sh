#!/usr/bin/env bash

set -x

flutter pub get
flutter analyze
dart format --output none --set-exit-if-changed .
