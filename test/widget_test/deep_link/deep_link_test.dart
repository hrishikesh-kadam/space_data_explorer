import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/route/home/home_screen.dart';
import 'package:space_data_explorer/route/settings/settings_screen.dart';
import '../../src/route/settings/settings_route.dart';
import '../../src/space_data_explorer_app.dart';

void main() {
  /// For rest of the Deep-link Tests, see:
  /// - test/widget_test/config/app_bar_back_button_test.dart
  /// - test/widget_test/config/app_back_button_dispatcher_test.dart
  group('Deep-link Tests',
      skip: 'Waiting for https://github.com/flutter/packages/pull/5113', () {
    testWidgets('DeferredLoading workaround', (tester) async {
      await pumpApp(tester);
      await tapSettingsAction(tester);
    });

    testWidgets('Https URL with no path', (tester) async {
      const String deepLink = 'https://domain.com';
      await pumpApp(tester, initialLocation: deepLink);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Https URL with no path, trailing slash', (tester) async {
      const String deepLink = 'https://domain.com/';
      await pumpApp(tester, initialLocation: deepLink);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Settings Page', (tester) async {
      const String deepLink = 'https://domain.com/settings';
      await pumpApp(tester, initialLocation: deepLink);
      expect(find.byType(SettingsScreen), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
    });
  });
}
