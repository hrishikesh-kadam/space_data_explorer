import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/nasa/cad/bloc/cad_bloc.dart';
import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/nasa/route/nasa_screen.dart';
import 'package:space_data_explorer/widgets/filter_container.dart';
import '../../space_data_explorer_app.dart';
import '../route/nasa_route.dart';
import 'sbdb_cad_api.dart';

final queryFilterGridFinder = find.byKey(CadScreen.queryFilterGridKey);
final queryFilterGridItemFinder = find.descendant(
  of: queryFilterGridFinder,
  matching: find.byType(QueryFilterContainer),
);

Future<void> pumpCadRouteAsInitialLocation(WidgetTester tester) async {
  CadScreen.cadBloc = getCadBloc();
  await pumpApp(tester, initialLocation: CadRoute.path);
  expect(find.byType(CadScreen), findsOneWidget);
}

Future<void> pumpCadRouteAsNormalLink(WidgetTester tester) async {
  await pumpNasaRouteAsNormalLink(tester);
  CadScreen.cadBloc = getCadBloc();
  await tester.tap(find.byKey(NasaScreen.cadButtonKey));
  await tester.pumpAndSettle();
  expect(find.byType(NasaScreen, skipOffstage: false), findsOneWidget);
  expect(find.byType(CadScreen), findsOneWidget);
}

CadBloc getCadBloc() {
  return CadBloc(sbdbCadApi: getMockedSbdbCadApi());
}
