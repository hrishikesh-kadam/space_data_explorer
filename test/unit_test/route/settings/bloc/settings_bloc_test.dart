import 'dart:io';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:space_data_explorer/config/config.dart';
import 'package:space_data_explorer/language/language.dart';
import 'package:space_data_explorer/route/settings/bloc/settings_bloc.dart';

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
      late Storage storage;
      final storageDirectory = Directory(
        'build/test/unit_test/route/settings/bloc/storage',
      );

      setUp(() async {
        storage = await HydratedStorage.build(
          storageDirectory: storageDirectory,
        );
        HydratedBloc.storage = storage;
      });

      tearDown(() async {
        await storage.clear();
        try {
          await HydratedStorage.hive.deleteFromDisk();
          storageDirectory.deleteSync(recursive: true);
        } catch (_) {}
      });

      test('InitialSettings', () async {
        final SettingsBloc hydratedBloc = SettingsBloc.getInitialSettings();
        hydratedBloc.add(
          const SettingsLaguageSelected(
            language: Language.english,
          ),
        );
        await sleep();
        final SettingsBloc reHydratedBloc = SettingsBloc.getInitialSettings();
        expect(reHydratedBloc.state, hydratedBloc.state);
      });

      test('systemLocales', () async {
        final SettingsBloc hydratedBloc = SettingsBloc.getInitialSettings();
        hydratedBloc.add(
          const SettingsLaguageSelected(
            language: Language.english,
          ),
        );
        hydratedBloc.add(
          const SettingsSystemLocalesChanged(systemLocales: [
            Locale('mr'),
            Locale('en'),
          ]),
        );
        await sleep();
        final SettingsBloc reHydratedBloc = SettingsBloc.getInitialSettings();
        expect(reHydratedBloc.state, hydratedBloc.state);
      });
    });
  });
}
