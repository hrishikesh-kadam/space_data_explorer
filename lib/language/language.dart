enum Language {
  english('en', 'English'),
  hindi('hi', 'हिंदी'),
  marathi('mr', 'मराठी');

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
