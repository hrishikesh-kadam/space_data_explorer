import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/nasa/nasa_route.dart';
import 'package:space_data_explorer/nasa/nasa_screen.dart';
import 'package:space_data_explorer/route/home/home_screen.dart';
import 'package:space_data_explorer/route/settings/settings_route.dart';
import 'package:space_data_explorer/route/settings/settings_screen.dart';
import '../../../src/nasa/route/nasa_route.dart';
import '../../../src/route/settings/settings_route.dart';

void main() {
  group('$SettingsRoute Widget Test', () {
    testWidgets('Navigate $NasaRoute to $SettingsRoute to $NasaRoute',
        (WidgetTester tester) async {
      await pumpNasaRouteAsInitialLocation(tester);
      await tapSettingsButton(tester);
      expect(find.byType(NasaScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(SettingsScreen), findsOneWidget);
      await tapBackButton(tester);
      expect(find.byType(SettingsScreen), findsNothing);
      expect(find.byType(NasaScreen), findsOneWidget);
    });

    testWidgets('Basic', (WidgetTester tester) async {
      await pumpSettingsRouteAsInitialLocation(tester);
    });

    testWidgets('Navigate back', (WidgetTester tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      await tapBackButton(tester);
      expect(find.byType(SettingsScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
