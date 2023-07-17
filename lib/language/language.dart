import 'package:json_annotation/json_annotation.dart';

enum Language {
  @JsonValue('en')
  english('en', 'English'),
  @JsonValue('hi')
  hindi('hi', 'हिंदी (Hindi)'),
  @JsonValue('mr')
  marathi('mr', 'मराठी (Marathi)');

  const Language(this.code, this.displayName);

  factory Language.fromCode(String code) {
    switch (code) {
      case 'en':
        return english;
      case 'hi':
        return hindi;
      case 'mr':
        return marathi;
      default:
        throw UnsupportedError('Language with $code is not yet supported');
    }
  }

  final String code;
  final String displayName;
}
