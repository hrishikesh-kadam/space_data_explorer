# Contributing

If you wish to contribute then please first open an issue to discuss the need.  
As the intended purposes are limited I may not be able to merge your request.

This repository consist of dev (HEAD), stag, prod branches.  
You should raise the PR on the dev branch.  
Refer [`.github/workflows/ci-contributors.yml`] to know more.


## Prerequisites

Based on your interest, you might have to run one of the below.  
Refer [`./tool/prerequisite.sh`] script.  
Not all packages are required to run the project.

1. Minimal  
   For those who just wish to run this project.
   ```console
   ./tool/prerequisite.sh --minimal
   ```

2. Contributors  
   For those who wish to contribute to this project.
   ```console
   ./tool/prerequisite.sh --contributor
   ```

3. Members  
   For active members of this project.
   ```console
   ./tool/prerequisite.sh --member
   ```


## CI

Refer [`./tool/ci.sh`] script to start building this project.


## Release Notes

Following are the release related files:
- [`pubspec.yaml`]
- [`lib/constants/constants.dart`]
- [`CHANGELOG.md`]
- [`android/fastlane/prod/metadata/android/en-US/changelogs/default.txt`]


[`.github/workflows/ci-contributors.yml`]: .github/workflows/ci-contributors.yml
[`./tool/prerequisite.sh`]: ./tool/prerequisite.sh
[`./tool/ci.sh`]: ./tool/ci.sh
[`pubspec.yaml`]: pubspec.yaml
[`lib/constants/constants.dart`]: lib/constants/constants.dart
[`CHANGELOG.md`]: CHANGELOG.md
[`android/fastlane/prod/metadata/android/en-US/changelogs/default.txt`]: android/fastlane/prod/metadata/android/en-US/changelogs/default.txt
