import 'package:json_annotation/json_annotation.dart';

enum Language {
  @JsonValue('system')
  system(code: 'system'),
  @JsonValue('en')
  english(code: 'en', displayName: 'English'),
  @JsonValue('hi')
  hindi(code: 'hi', displayName: 'हिंदी (Hindi)'),
  @JsonValue('mr')
  marathi(code: 'mr', displayName: 'मराठी (Marathi)');

  const Language({
    required this.code,
    this.displayName,
  });

  // factory Language.fromCode(String code) {
  //   switch (code) {
  //     case 'system':
  //       return system;
  //     case 'en':
  //       return english;
  //     case 'hi':
  //       return hindi;
  //     case 'mr':
  //       return marathi;
  //     default:
  //       throw UnsupportedError('Language with $code is not yet supported');
  //   }
  // }

  final String code;
  final String? displayName;
}
