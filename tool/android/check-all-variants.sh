#!/usr/bin/env bash

set -e -o pipefail
# TODO(hrishikesh-kadam): Check this on Windows
if [[ $(uname -s) =~ ^"MINGW" ]]; then
  set +e +o pipefail
fi

pushd android &> /dev/null
CURRENT_VARIANTS=$(./gradlew -q :app:printAllVariants | csv2md)
if [[ -s ../secrets/android/key.properties ]]; then
  CHECKED_VARIANTS=../secrets/android/all-variants-members.md
else
  CHECKED_VARIANTS=all-variants-contributors.md
fi
diff --unified --color $CHECKED_VARIANTS <(echo "$CURRENT_VARIANTS")
popd &> /dev/null
