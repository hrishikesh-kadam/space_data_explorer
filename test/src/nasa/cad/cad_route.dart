import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';
import 'package:hrk_nasa_apis_test/hrk_nasa_apis_test.dart';
import 'package:mockito/mockito.dart';

import 'package:space_data_explorer/nasa/cad/bloc/cad_bloc.dart';
import 'package:space_data_explorer/nasa/cad/bloc/cad_state.dart';
import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/nasa/cad_result/cad_result_screen.dart';
import 'package:space_data_explorer/widgets/query_grid_container.dart';
import '../../space_data_explorer_app.dart';
import '../route/nasa_route.dart';

final customScrollViewFinder = find.byKey(CadScreen.customScrollViewKey);
final searchButtonFinder = find.byKey(CadScreen.searchButtonKey);
final queryGridFinder = find.byKey(CadScreen.queryGridKey);
final queryGridItemFinder = find.descendant(
  of: queryGridFinder,
  matching: find.byType(QueryItemContainer),
);
final snackBarFinder = find.byKey(CadScreen.snackBarKey);

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
  await tapCadButton(tester);
}

CadBloc getCadBloc({
  SbdbCadApi? sbdbCadApi,
  CadState? initialState,
}) {
  return CadBloc(
    sbdbCadApi: sbdbCadApi ??
        SbdbCadApiExt.getAnswers(
          response: SbdbCadApiExt.getResponseSbdbCadBody('200/0'),
        ),
    initialState: initialState,
  );
}

Future<void> tapSearchButton(WidgetTester tester) async {
  await tester.tap(searchButtonFinder);
  await tester.pumpAndSettle();
}

Future<void> scrollToTop(WidgetTester tester) async {
  final offset = tester
      .widget<CustomScrollView>(customScrollViewFinder)
      .controller!
      .offset;
  await tester.drag(customScrollViewFinder, Offset(0, offset));
  await tester.pumpAndSettle();
}

Future<void> verifyQueryParameters(
  WidgetTester tester,
  SbdbCadQueryParameters queryParameters,
) async {
  await scrollToTop(tester);
  await tapSearchButton(tester);
  expect(find.byType(CadScreen, skipOffstage: false), findsOneWidget);
  expect(find.byType(CadResultScreen), findsOneWidget);
  final sbdbCadApi = CadScreen.cadBloc!.sbdbCadApi;
  verify(sbdbCadApi.get(
    queryParameters: queryParameters.toJson(),
    cancelToken: anyNamed('cancelToken'),
  )).called(1);
  clearInteractions(sbdbCadApi);
  await tapBackButton(tester);
}

Future<void> emitDisableInputs(WidgetTester tester) async {
  CadScreen.cadBloc!.emit(CadScreen.cadBloc!.state.copyWith(
    disableInputs: true,
  ));
  await tester.pumpAndSettle();
}
