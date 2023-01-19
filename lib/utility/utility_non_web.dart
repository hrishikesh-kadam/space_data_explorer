import 'dart:io';

bool isFlutterTest() {
  bool flutterTest = Platform.environment.containsKey('FLUTTER_TEST');
  if (flutterTest) {
    return flutterTest;
  }
  flutterTest = const bool.fromEnvironment('FLUTTER_TEST');
  return flutterTest;
}
