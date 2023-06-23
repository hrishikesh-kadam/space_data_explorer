import 'dart:io';

bool isAndroid = Platform.isAndroid;

bool isFlutterTest() {
  // For Unit and Widget Test run as `flutter test` or `flutter run`,
  // `FLUTTER_TEST` is set to true
  bool flutterTest = Platform.environment.containsKey('FLUTTER_TEST');
  if (flutterTest) {
    return flutterTest;
  }
  // For Integration Test run as `flutter test` or `flutter drive`,
  // `FLUTTER_TEST` needs to be passed as --dart-define="FLUTTER_TEST=true"
  flutterTest = const bool.fromEnvironment('FLUTTER_TEST');
  return flutterTest;
}
