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

    testWidgets('200/body', (WidgetTester tester) async {
      final JsonMap $extra = {
        '$SbdbCadBody': SbdbCadBodyExt.getSample('200/body'),
      };
      await pumpCadResultRouteAsInitialLocation(tester, $extra: $extra);
      expect(find.byType(CadResultScreen), findsOneWidget);
      expect(resultGridFinder, findsOneWidget);
      expect(bodyLabelFinder, findsWidgets);
      expect(bodyDisplayValueFinder, findsWidgets);
    });

    testWidgets('200/diameter', (WidgetTester tester) async {
      final JsonMap $extra = {
        '$SbdbCadBody': SbdbCadBodyExt.getSample('200/diameter'),
      };
      await pumpCadResultRouteAsInitialLocation(tester, $extra: $extra);
      expect(find.byType(CadResultScreen), findsOneWidget);
      expect(resultGridFinder, findsOneWidget);
      expect(diameterLabelFinder, findsWidgets);
      expect(diameterDisplayValueFinder, findsWidgets);
    });

    testWidgets('200/fullname', (WidgetTester tester) async {
      final JsonMap $extra = {
        '$SbdbCadBody': SbdbCadBodyExt.getSample('200/fullname'),
      };
      await pumpCadResultRouteAsInitialLocation(tester, $extra: $extra);
      expect(find.byType(CadResultScreen), findsOneWidget);
      expect(resultGridFinder, findsOneWidget);
      expect(fullnameLabelFinder, findsWidgets);
      expect(fullnameDisplayValueFinder, findsWidgets);
    });

    testWidgets('200/all-fields', (WidgetTester tester) async {
      final JsonMap $extra = {
        '$SbdbCadBody': SbdbCadBodyExt.getSample('200/all-fields'),
      };
      await pumpCadResultRouteAsInitialLocation(tester, $extra: $extra);
      expect(find.byType(CadResultScreen), findsOneWidget);
      expect(resultGridFinder, findsOneWidget);
      expect(bodyLabelFinder, findsWidgets);
      expect(bodyDisplayValueFinder, findsWidgets);
      expect(diameterLabelFinder, findsWidgets);
      expect(diameterDisplayValueFinder, findsWidgets);
      expect(fullnameLabelFinder, findsWidgets);
      expect(fullnameDisplayValueFinder, findsWidgets);
    });
  });
}
