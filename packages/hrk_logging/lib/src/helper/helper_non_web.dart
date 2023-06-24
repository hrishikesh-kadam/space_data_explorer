import 'dart:io';

bool isDartOrFlutterTest() {
  // In Dart -
  // Run command as `DART_TEST=true dart test`
  bool dartTest = Platform.environment.containsKey('DART_TEST');
  if (dartTest) {
    return true;
  }
  // In Flutter -
  // For Unit and Widget Test run as `flutter test` or `flutter run`,
  // `FLUTTER_TEST` is set to true
  final bool flutterTest = Platform.environment.containsKey('FLUTTER_TEST');
  if (flutterTest) {
    return true;
  }
  // In Flutter -
  // For Integration Test run as `flutter test`,
  // `FLUTTER_TEST` needs to be passed as --dart-define="FLUTTER_TEST=true"
  return const bool.fromEnvironment('FLUTTER_TEST');
}
