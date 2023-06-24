import 'helper_non_web.dart' if (dart.library.html) 'helper_web.dart'
    as platform;

bool isDartOrFlutterTest() => platform.isDartOrFlutterTest();
