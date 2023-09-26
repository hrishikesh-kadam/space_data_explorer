import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_batteries/hrk_batteries.dart';

import 'package:space_data_explorer/extension/distance.dart';
import '../../src/globals.dart';

void main() {
  group('DistanceUnitExt', () {
    test('getLocalizedSymbol()', () {
      // LABEL: coverage-sake
      for (final distanceUnit in [
        ...DistanceUnit.all,
        const DistanceUnit(symbol: ''),
      ]) {
        final actualLocalizedSymbol = distanceUnit.getLocalizedSymbol(l10n);
        expect(actualLocalizedSymbol, distanceUnit.symbol);
      }
    });
  });
}
