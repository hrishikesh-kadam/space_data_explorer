import 'dart:io';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_logging/hrk_logging.dart';

import 'package:space_data_explorer/config/config.dart';
import 'package:space_data_explorer/route/settings/bloc/settings_bloc.dart';
import 'package:space_data_explorer/route/settings/date_format_pattern.dart';
import 'package:space_data_explorer/route/settings/locale.dart';
import '../../../../src/config/hydrated_bloc.dart';

Future<void> sleep() => Future<void>.delayed(const Duration(milliseconds: 100));

/// Sources:
/// 1. https://github.com/felangel/bloc/blob/master/packages/hydrated_bloc/test/e2e_test.dart
/// 2. https://github.com/felangel/bloc/blob/master/packages/hydrated_bloc/test/hydrated_storage_test.dart
void main() {
  group('$SettingsBloc Unit Test', () {
    setUpAll(() {
      configureHrkLogging();
      configureBloc();
    });

    group('Hydration', () {
      final storageDirectory = Directory(
        'build/test/unit_test/route/settings/bloc/storage',
      );

      setUp(() async {
        await setUpHydratedBloc(storageDirectory);
      });

      tearDown(() async {
        await tearDownHydratedBloc(storageDirectory);
      });

      test('$SettingsLocaleSelected', () async {
        final SettingsBloc hydratedBloc = SettingsBloc();
        hydratedBloc.add(
          const SettingsLocaleSelected(
            locale: LocaleExt.en,
          ),
        );
        await sleep();
        final SettingsBloc reHydratedBloc = SettingsBloc();
        expect(reHydratedBloc.state, hydratedBloc.state);
      });

      test('$SettingsDateFormatSelected', () async {
        final SettingsBloc hydratedBloc = SettingsBloc();
        hydratedBloc.add(
          const SettingsDateFormatSelected(
            dateFormatPattern: DateFormatPattern.ddMMyyyySlash,
          ),
        );
        await sleep();
        final SettingsBloc reHydratedBloc = SettingsBloc();
        expect(reHydratedBloc.state, hydratedBloc.state);
      });

      test('$SettingsDialogEvent', () async {
        final SettingsBloc hydratedBloc = SettingsBloc();
        hydratedBloc.add(
          const SettingsDialogEvent(
            isAnyDialogShown: false,
          ),
        );
        await sleep();
        final SettingsBloc reHydratedBloc = SettingsBloc();
        expect(reHydratedBloc.state, hydratedBloc.state);
      });

      test('$SettingsSystemLocalesChanged', () async {
        final SettingsBloc hydratedBloc = SettingsBloc();
        hydratedBloc.add(
          const SettingsSystemLocalesChanged(systemLocales: [
            Locale('mr'),
            Locale('en'),
          ]),
        );
        await sleep();
        final SettingsBloc reHydratedBloc = SettingsBloc();
        expect(reHydratedBloc.state, hydratedBloc.state);
      });
    });
  });
}
