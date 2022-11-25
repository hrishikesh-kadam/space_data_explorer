#!/usr/bin/env bash

set -x

flutter pub get
dart analyze
dart format --output none --set-exit-if-changed .
