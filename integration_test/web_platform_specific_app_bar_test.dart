import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:logging/logging.dart';

import 'package:space_data_explorer/pages/home_page.dart';
import 'package:space_data_explorer/pages/nasa_source_page.dart';
import 'package:space_data_explorer/pages/neows_page.dart';
import 'package:space_data_explorer/main.dart' as app;

import 'nasa_source_page_test.dart';
import 'test_utility_non_web.dart'
    if (dart.library.html) 'test_utility_web.dart' as test_utility;
import 'neows_page_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('getPlatformSpecificAppBar() Integration Test for Web', () {
    testWidgets('3 pages down and 2 pages up', (tester) async {
      await neowsPageIntegrationTest(tester);

      final neowsPageBackButton = find.byType(BackButton);
      await tester.tap(neowsPageBackButton);
      await tester.pumpAndSettle();
      expect(find.byType(NeowsScreen), findsNothing);
      expect(find.byType(NasaSourceScreen), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      if (kIsWeb) {
        test_utility.checkHistoryLengthAndSerialCount(3, 1);
      }

      final nasaSourcePageBackButton = find.byType(BackButton);
      await tester.tap(nasaSourcePageBackButton);
      await tester.pumpAndSettle();
      expect(find.byType(NeowsScreen), findsNothing);
      expect(find.byType(NasaSourceScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
      if (kIsWeb) {
        test_utility.checkHistoryLengthAndSerialCount(3, 0);
      }
      Logger.root.clearListeners();
    });

    testWidgets('2 pages down and 1 page up', (tester) async {
      await nasaSourcePageIntegrationTest(tester);

      final nasaSourcePageBackButton = find.byType(BackButton);
      await tester.tap(nasaSourcePageBackButton);
      await tester.pumpAndSettle();
      expect(find.byType(NasaSourceScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
      if (kIsWeb) {
        test_utility.checkHistoryLengthAndSerialCount(2, 0);
      }
      Logger.root.clearListeners();
    });

    testWidgets('deep-link to 3rd level and press back', (tester) async {
      app.main(initialLocation: NeowsPage.path);
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      expect(
          find.byType(NasaSourceScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(NeowsScreen), findsOneWidget);

      final neowsPageBackButton = find.byType(BackButton);
      await tester.tap(neowsPageBackButton);
      await tester.pumpAndSettle();
      expect(find.byType(NeowsScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
      if (kIsWeb) {
        test_utility.checkHistoryLengthAndSerialCount(2, 0);
      }
      Logger.root.clearListeners();
    });

    testWidgets('deep-link to 2nd level and press back', (tester) async {
      app.main(initialLocation: NasaSourcePage.path);
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(NasaSourceScreen), findsOneWidget);

      final nasaSourcePageBackButton = find.byType(BackButton);
      await tester.tap(nasaSourcePageBackButton);
      await tester.pumpAndSettle();
      expect(find.byType(NasaSourceScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
      if (kIsWeb) {
        test_utility.checkHistoryLengthAndSerialCount(2, 0);
      }
      Logger.root.clearListeners();
    });
  });
}
