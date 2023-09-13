import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/route/settings/locale.dart';

void main() {
  group('LocaleExt Unit Test', () {
    test('toDisplayName', () {
      const Locale locale = Locale('hi-Deva-IN');
      expect('hi-Deva-IN', locale.toDisplayName());
    });
  });
}
