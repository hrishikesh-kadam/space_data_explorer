import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_batteries/hrk_batteries.dart';

import 'package:space_data_explorer/route/settings/settings_screen.dart';
import '../../../src/globals.dart';

void main() {
  group('$SettingsScreen Unit Test', () {
    group('getDistanceUnitValueTitle()', () {
      test('throwsArgumentError', () {
        expect(
          () => SettingsScreen.getDistanceUnitValueTitle(
            l10n: l10n,
            distanceUnit: const DistanceUnit(symbol: ''),
          ),
          throwsArgumentError,
        );
      });
    });

    group('getVelocityUnitValueTitle()', () {
      test('throwsArgumentError', () {
        expect(
          () => SettingsScreen.getVelocityUnitValueTitle(
            l10n: l10n,
            velocityUnit: const VelocityUnit(symbol: ''),
          ),
          throwsArgumentError,
        );
      });
    });

    group('getDiameterUnitValueTitle()', () {
      test('throwsArgumentError', () {
        expect(
          () => SettingsScreen.getDiameterUnitValueTitle(
            l10n: l10n,
            diameterUnit: const DistanceUnit(symbol: ''),
          ),
          throwsArgumentError,
        );
      });
    });
  });
}
