import 'helper/helper.dart';

const bool kReleaseMode = bool.fromEnvironment('dart.vm.product');
const bool kProfileMode = bool.fromEnvironment('dart.vm.profile');
const bool kDebugMode = !kReleaseMode && !kProfileMode;

bool dartOrFlutterTest = isDartOrFlutterTest();
