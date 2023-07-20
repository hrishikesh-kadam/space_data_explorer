import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/globals.dart';
import 'package:space_data_explorer/nasa/cad/bloc/cad_bloc.dart';
import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/nasa/nasa_screen.dart';
import 'package:space_data_explorer/typedef/typedef.dart';
import 'globals.dart';
import 'nasa_route_helper.dart';
import 'sbdb_cad_api.dart';
import 'space_data_explorer_app_test.dart';

Future<void> pumpCadRouteAsInitialLocation(WidgetTester tester) async {
  CadScreen.cadBloc = getCadBloc();
  await pumpApp(tester, initialLocation: CadRoute.path);
  expect(find.byType(CadScreen), findsOneWidget);
}

Future<void> pumpCadRouteAsNormalLink(WidgetTester tester) async {
  await pumpNasaRouteAsNormalLink(tester);
  final RouteExtraMap routeExtraMap = getRouteExtra();
  routeExtraMap['$CadBloc'] = getCadBloc();
  CadRoute($extra: routeExtraMap).go(navigatorKey.currentContext!);
  await tester.pumpAndSettle();
  expect(find.byType(NasaScreen, skipOffstage: false), findsOneWidget);
  expect(find.byType(CadScreen), findsOneWidget);
}

CadBloc getCadBloc() {
  return CadBloc(sbdbCadApi: getMockedSbdbCadApi());
}
