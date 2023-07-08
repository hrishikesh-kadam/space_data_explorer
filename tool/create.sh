#!/usr/bin/env bash

set -e -o pipefail

flutter create . --org "dev.hrishikesh_kadam.flutter"

dart run build_runner build --delete-conflicting-outputs
