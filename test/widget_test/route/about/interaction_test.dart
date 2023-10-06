import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_logging/hrk_logging.dart';

import 'package:space_data_explorer/route/about/about_route.dart';
import 'package:space_data_explorer/route/about/about_screen.dart';
import '../../../src/globals.dart';
import '../../../src/route/about/about_route.dart';

void main() {
  group('$AboutRoute Interaction Test', () {
    testWidgets('Tap Linktree Uri, press back', (WidgetTester tester) async {
      await pumpAboutRouteAsInitialLocation(tester);
      await tapLinktreeUri(tester);
      expect(find.byType(AboutScreen, skipOffstage: false), findsOneWidget);
      SystemNavigator.pop();
      expect(find.byType(AboutScreen), findsOneWidget);
      printLogger.debug(tester.testDescription);
    });

    testWidgets('Tap Source Uri, press back', (WidgetTester tester) async {
      await pumpAboutRouteAsInitialLocation(tester);
      await tapSourceUri(tester);
      expect(find.byType(AboutScreen, skipOffstage: false), findsOneWidget);
      SystemNavigator.pop();
      expect(find.byType(AboutScreen), findsOneWidget);
      printLogger.debug(tester.testDescription);
    });

    testWidgets('Tap Web App Uri, press back', (WidgetTester tester) async {
      await pumpAboutRouteAsInitialLocation(tester);
      await tapWebAppUri(tester);
      expect(find.byType(AboutScreen, skipOffstage: false), findsOneWidget);
      SystemNavigator.pop();
      expect(find.byType(AboutScreen), findsOneWidget);
      printLogger.debug(tester.testDescription);
    });
  });
}
