import 'package:pubspec_parse/pubspec_parse.dart';

// LABEL: eligible-hrk_batteries
extension PubspecExt on Pubspec {
  String? getVersionMajorMinorPatch() {
    if (version == null) {
      return null;
    }
    return '${version!.major}.${version!.minor}.${version!.patch}';
  }
}
