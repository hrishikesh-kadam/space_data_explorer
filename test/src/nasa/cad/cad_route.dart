import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/nasa/cad/bloc/cad_bloc.dart';
import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/nasa/route/nasa_screen.dart';
import 'package:space_data_explorer/widgets/query_grid_container.dart';
import '../../space_data_explorer_app.dart';
import '../route/nasa_route.dart';
import 'sbdb_cad_api.dart';

final customScrollViewFinder = find.byKey(CadScreen.customScrollViewKey);
final searchButtonFinder = find.byKey(CadScreen.searchButtonKey);
final queryGridFinder = find.byKey(CadScreen.queryGridKey);
final queryGridItemFinder = find.descendant(
  of: queryGridFinder,
  matching: find.byType(QueryItemContainer),
);

Future<void> pumpCadRouteAsInitialLocation(
  WidgetTester tester, {
  CadBloc? cadBloc,
}) async {
  CadScreen.cadBloc = cadBloc ?? getCadBloc();
  await pumpApp(tester, initialLocation: CadRoute.path);
}

Future<void> pumpCadRouteAsNormalLink(
  WidgetTester tester, {
  CadBloc? cadBloc,
}) async {
  await pumpNasaRouteAsNormalLink(tester);
  CadScreen.cadBloc = cadBloc ?? getCadBloc();
  await tester.tap(find.byKey(NasaScreen.cadButtonKey));
  await tester.pumpAndSettle();
}

CadBloc getCadBloc() {
  return CadBloc(sbdbCadApi: getMockedSbdbCadApi());
}

Future<void> ensureSearchButtonVisible(WidgetTester tester) async {
  await tester.dragUntilVisible(
    searchButtonFinder,
    customScrollViewFinder,
    const Offset(0, 200),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.byType(AppBar));
  await tester.pumpAndSettle();
}

Future<void> tapSearchButton(WidgetTester tester) async {
  await tester.tap(searchButtonFinder);
  await tester.pumpAndSettle();
}
