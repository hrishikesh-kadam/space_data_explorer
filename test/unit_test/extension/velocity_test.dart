import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_batteries/hrk_batteries.dart';

import 'package:space_data_explorer/extension/velocity.dart';
import '../../src/globals.dart';

void main() {
  group('VelocityUnitExt', () {
    test('getLocalizedSymbol()', () {
      // LABEL: coverage-sake
      for (final velocityUnit in [
        ...VelocityUnit.all,
        const VelocityUnit(symbol: ''),
      ]) {
        final actualLocalizedSymbol = velocityUnit.getLocalizedSymbol(l10n);
        expect(actualLocalizedSymbol, velocityUnit.symbol);
      }
    });
  });
}
