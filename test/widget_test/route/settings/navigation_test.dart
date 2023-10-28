import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/nasa/route/nasa_route.dart';
import 'package:space_data_explorer/nasa/route/nasa_screen.dart';
import 'package:space_data_explorer/route/home/home_screen.dart';
import 'package:space_data_explorer/route/settings/settings_route.dart';
import 'package:space_data_explorer/route/settings/settings_screen.dart';
import '../../../src/nasa/route/nasa_route.dart';
import '../../../src/route/settings/settings_route.dart';
import '../../../src/space_data_explorer_app.dart';

void main() {
  group('$SettingsRoute Widget Test', () {
    testWidgets('Navigate $NasaRoute to $SettingsRoute to $NasaRoute',
        (WidgetTester tester) async {
      await pumpNasaRouteAsInitialLocation(tester);
      await tapSettingsAction(tester);
      expect(find.byType(NasaScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(SettingsScreen), findsOneWidget);
      await tapBackButton(tester);
      expect(find.byType(SettingsScreen), findsNothing);
      expect(find.byType(NasaScreen), findsOneWidget);
    });

    testWidgets('As initialLocation', (WidgetTester tester) async {
      await pumpSettingsRouteAsInitialLocation(tester);
      expect(find.byType(SettingsScreen), findsOneWidget);
      expect(settingsActionFinder, findsNothing);
    });

    testWidgets('Navigate back', (WidgetTester tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(SettingsScreen), findsOneWidget);
      expect(settingsActionFinder, findsNothing);
      await tapBackButton(tester);
      expect(find.byType(SettingsScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Deep-link', (tester) async {
      tester.platformDispatcher.defaultRouteNameTestValue =
          SettingsRoute.uri.path;
      await pumpApp(tester);
      tester.platformDispatcher.clearDefaultRouteNameTestValue();
      expect(find.byType(SettingsScreen), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
    });
  });
}
