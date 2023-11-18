import 'package:pubspec_parse/pubspec_parse.dart';

extension PubspecExt on Pubspec {
  String? getVersionMajorMinorPatch() {
    if (version == null) {
      return null;
    }
    return '${version!.major}.${version!.minor}.${version!.patch}';
  }
}
