bool isDartOrFlutterTest() {
  // In Dart -
  // Run command as `DART_TEST=true dart test`
  const dartTest = bool.fromEnvironment('DART_TEST');
  if (dartTest) {
    return true;
  }
  // In Flutter -
  // For Integration Test run as `flutter drive`,
  // `FLUTTER_TEST` needs to be passed as --dart-define="FLUTTER_TEST=true"
  return const bool.fromEnvironment('FLUTTER_TEST');
}
