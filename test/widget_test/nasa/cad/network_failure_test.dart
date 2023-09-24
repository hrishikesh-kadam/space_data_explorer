import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';
import 'package:hrk_nasa_apis_test/hrk_nasa_apis_test.dart';
import 'package:recase/recase.dart';

import 'package:space_data_explorer/constants/constants.dart';
import 'package:space_data_explorer/nasa/cad/bloc/cad_state.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/nasa/cad_result/cad_result_screen.dart';
import '../../../src/nasa/cad/cad_route.dart';

void main() {
  group('$CadScreen ${NetworkState.failure}', () {
    testWidgets('${DioExceptionType.badResponse} 400', (tester) async {
      const int statusCodeInt = 400;
      final dioException = SbdbCadApiExt.getBadResponseException(
        statusCode: statusCodeInt,
        jsonFileName: '0',
      );
      final cadBloc = getCadBloc(
        sbdbCadApi: SbdbCadApiExt.getThrows(throwable: dioException),
      );
      await pumpCadRouteAsInitialLocation(tester, cadBloc: cadBloc);
      await tapSearchButton(tester);
      expect(find.byType(CadResultScreen), findsNothing);
      expect(find.byType(CadScreen), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
      final Text snackBarContent =
          tester.widget<SnackBar>(snackBarFinder).content as Text;
      expect(snackBarContent.data, contains(somethingWentWrong));
      expect(snackBarContent.data, contains('$statusCode: $statusCodeInt'));
    });

    testWidgets('${DioExceptionType.connectionError}', (tester) async {
      final dioException = DioException.connectionError(
        requestOptions: RequestOptions(),
        reason: '',
      );
      final cadBloc = getCadBloc(
        sbdbCadApi: SbdbCadApiExt.getThrows(throwable: dioException),
      );
      await pumpCadRouteAsInitialLocation(tester, cadBloc: cadBloc);
      await tapSearchButton(tester);
      expect(find.byType(CadResultScreen), findsNothing);
      expect(find.byType(CadScreen), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
      final Text snackBarContent =
          tester.widget<SnackBar>(snackBarFinder).content as Text;
      expect(
        snackBarContent.data,
        contains(dioException.type.name.sentenceCase),
      );
    });

    testWidgets('Unknown Exception', (tester) async {
      final exception = Exception('Unknown Exception');
      final cadBloc = getCadBloc(
        sbdbCadApi: SbdbCadApiExt.getThrows(throwable: exception),
      );
      await pumpCadRouteAsInitialLocation(tester, cadBloc: cadBloc);
      await tapSearchButton(tester);
      expect(find.byType(CadResultScreen), findsNothing);
      expect(find.byType(CadScreen), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
      final Text snackBarContent =
          tester.widget<SnackBar>(snackBarFinder).content as Text;
      expect(snackBarContent.data, somethingWentWrong);
    });

    testWidgets('${DioExceptionType.cancel}', (tester) async {
      const milliseconds = 5000;
      const delay = Duration(milliseconds: milliseconds);
      const halfDelay = Duration(milliseconds: milliseconds ~/ 2);
      final resposne = SbdbCadApiExt.getResponseSbdbCadBody('200/0');
      final SbdbCadApi sbdbCadApi = SbdbCadApiExt.getAnswers(
        response: resposne,
        delay: delay,
      );
      final cadBloc = getCadBloc(sbdbCadApi: sbdbCadApi);
      await pumpCadRouteAsInitialLocation(tester, cadBloc: cadBloc);
      await tester.tap(searchButtonFinder);
      await tester.pump(halfDelay);
      await tapBackButton(tester);
      await tester.pump(halfDelay);
      expect(find.byType(CadResultScreen), findsNothing);
      expect(find.byType(CadScreen), findsNothing);
    });
  });
}
