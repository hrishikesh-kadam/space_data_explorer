bool isAndroid = false;

// For Integration Test run as `flutter drive`,
// `FLUTTER_TEST` needs to be passed as --dart-define="FLUTTER_TEST=true"
bool isFlutterTest() => const bool.fromEnvironment('FLUTTER_TEST');
