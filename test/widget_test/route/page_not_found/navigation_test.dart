import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/nasa/route/nasa_screen.dart';
import 'package:space_data_explorer/route/home/home_screen.dart';
import 'package:space_data_explorer/route/page_not_found/page_not_found_route.dart';
import 'package:space_data_explorer/route/page_not_found/page_not_found_screen.dart';
import '../../../src/nasa/route/nasa_route.dart';

void main() {
  /// For rest of the Navigation Tests, see:
  /// - test/widget_test/config/app_bar_back_button_test.dart
  /// - test/widget_test/config/app_back_button_dispatcher_test.dart
  group('$PageNotFoundRoute Navigation Test', () {
    testWidgets(
        'Navigate from 2nd level route to non-existing-link, press back',
        (tester) async {
      await pumpNasaRouteAsInitialLocation(tester);
      await tapNonExistingPathButton(tester);
      expect(find.byType(NasaScreen, skipOffstage: false), findsNothing);
      expect(find.byType(PageNotFoundScreen), findsOneWidget);
      await tapBackButton(tester);
      expect(find.byType(PageNotFoundScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
