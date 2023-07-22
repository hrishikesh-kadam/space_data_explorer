import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:space_data_explorer/language/language.dart';
import 'package:space_data_explorer/route/settings/bloc/settings_bloc.dart';

void main() {
  group('$SettingsBloc Unit Test', () {
    group('Hydration', () {
      final storageDirectory = Directory(
        'build/test/unit_test/route/settings/bloc/storage',
      );

      setUp(() async {
        if (storageDirectory.existsSync()) {
          storageDirectory.deleteSync(recursive: true);
        }
        storageDirectory.createSync(recursive: true);
        WidgetsFlutterBinding.ensureInitialized();
        HydratedBloc.storage = await HydratedStorage.build(
          storageDirectory: storageDirectory,
        );
      });

      tearDownAll(() {
        if (storageDirectory.existsSync()) {
          storageDirectory.deleteSync(recursive: true);
        }
      });

      testWidgets('Basic', (tester) async {
        final SettingsBloc hydratedBloc = SettingsBloc.getInitialSettings();
        hydratedBloc.add(
          const SettingsLaguageSelected(
            language: Language.english,
          ),
        );
        await tester.pump();
        final SettingsBloc reHydratedBloc = SettingsBloc.getInitialSettings();
        expect(reHydratedBloc.state, hydratedBloc.state);
      });
    });
  });
}
