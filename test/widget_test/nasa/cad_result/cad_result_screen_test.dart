import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';
import 'package:hrk_nasa_apis_test/hrk_nasa_apis_test.dart';

import 'package:space_data_explorer/nasa/cad_result/cad_result_screen.dart';
import '../../../src/nasa/cad_result/cad_result_route.dart';

void main() {
  group('$CadResultScreen Widget Test', () {
    testWidgets('200/0', (WidgetTester tester) async {
      final JsonMap $extra = {
        '$SbdbCadBody': SbdbCadBodyExt.getSample('200/0'),
      };
      await pumpCadResultRouteAsInitialLocation(tester, $extra: $extra);
      expect(find.byType(CadResultScreen), findsOneWidget);
      expect(zeroCountTextFinder, findsOneWidget);
      expect(resultGridFinder, findsNothing);
    });

    testWidgets('200/1', (WidgetTester tester) async {
      final JsonMap $extra = {
        '$SbdbCadBody': SbdbCadBodyExt.getSample('200/1'),
      };
      await pumpCadResultRouteAsInitialLocation(tester, $extra: $extra);
      expect(find.byType(CadResultScreen), findsOneWidget);
      expect(resultGridFinder, findsOneWidget);
      expect(zeroCountTextFinder, findsNothing);
    });
  });
}
