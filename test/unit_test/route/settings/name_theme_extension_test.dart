import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/route/settings/name_theme_extension.dart';

void main() {
  group('$NameThemeExtension', () {
    group('copyWith()', () {
      test('no parameters', () {
        const NameThemeExtension a = NameThemeExtension(name: 'light');
        final NameThemeExtension b = a.copyWith();
        expect(b.name, a.name);
        expect(b.displayName, a.displayName);
      });

      test('displayName', () {
        const NameThemeExtension a = NameThemeExtension(name: 'light');
        final NameThemeExtension b = a.copyWith(displayName: 'Light');
        expect(b.displayName, 'Light');
      });
    });
  });
}
