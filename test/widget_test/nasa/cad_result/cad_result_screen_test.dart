import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_nasa_apis_test/hrk_nasa_apis_test.dart';

import 'package:space_data_explorer/nasa/cad/bloc/cad_bloc.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/nasa/cad_result/cad_result_screen.dart';
import '../../../src/nasa/cad/cad_route.dart';

void main() {
  group('$CadResultScreen Widget Test', () {
    testWidgets('200/0', (WidgetTester tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      await tapSearchButton(tester);
      expect(find.byType(CadScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(CadResultScreen), findsOneWidget);
    });

    testWidgets('200/1', (WidgetTester tester) async {
      final response = SbdbCadApiExt.getResponseSbdbCadBody('200/1');
      final sbdbCadApi = SbdbCadApiExt.getAnswers(response: response);
      final cadBloc = CadBloc(sbdbCadApi: sbdbCadApi);
      await pumpCadRouteAsInitialLocation(tester, cadBloc: cadBloc);
      await tapSearchButton(tester);
      expect(find.byType(CadScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(CadResultScreen), findsOneWidget);
    });
  });
}
