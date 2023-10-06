import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/route/about/about_route.dart';
import 'package:space_data_explorer/route/about/about_screen.dart';
import '../../../constants/dimensions.dart';
import '../../../src/route/about/about_route.dart';

void main() {
  group('$AboutRoute Painting Test', () {
    testWidgets('Doesn\'t Overflow ${TestDimensions.galaxyFoldPortraitWidth}',
        (WidgetTester tester) async {
      disableOverflowError();
      tester.view.setLogicalSize(width: TestDimensions.galaxyFoldPortraitWidth);
      await pumpAboutRouteAsInitialLocation(tester);
      expect(find.byType(AboutScreen), findsOneWidget);
      tester.expectNoOverflow(of: scaffoldFinder);
      await dragUntilLastItemVisible(tester);
      tester.expectNoOverflow(of: scaffoldFinder);
    });
  });
}
