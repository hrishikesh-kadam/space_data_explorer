import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/nasa/cad/bloc/cad_bloc.dart';
import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/widgets/filter_chip_query_widget.dart';
import '../../../../../src/nasa/cad/cad_route.dart';
import '../../../../../src/nasa/cad/query/data_output.dart';

void main() {
  group('$CadRoute ${FilterChipQueryWidget<DataOutput>} Interaction Test', () {
    testWidgets('DeferredLoading workaround', (tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      await tapSearchButton(tester);
    });

    testWidgets('No Interaction', (tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      await ensureDataOutputWidgetVisible(tester);
      expect(dataOutputWidgetFinder, findsOneWidget);
      expectDataOutputSelected(tester, <DataOutput>{});
      expect(CadScreen.cadBloc!.state.dataOutputSet, <DataOutput>{});
    });

    testWidgets('Select and Unselect each', (tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      for (final dataOutput in CadScreen.dataOutputSet) {
        final dataOutputSet = {dataOutput};
        await ensureDataOutputWidgetVisible(tester);
        await tapDataOutputChip(tester, dataOutput: dataOutput);
        expectDataOutputSelected(tester, dataOutputSet);
        expect(CadScreen.cadBloc!.state.dataOutputSet, dataOutputSet);
        await verifyDataOutputQueryParameters(tester, dataOutputSet);
        await ensureDataOutputWidgetVisible(tester);
        await tapDataOutputChip(tester, dataOutput: dataOutput);
        expectDataOutputSelected(tester, <DataOutput>{});
        expect(CadScreen.cadBloc!.state.dataOutputSet, <DataOutput>{});
      }
    });

    testWidgets('Select all, unselect all', (tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      Set<DataOutput> dataOutputSet = {};
      for (final dataOutput in CadScreen.dataOutputSet) {
        dataOutputSet.add(dataOutput);
        await ensureDataOutputWidgetVisible(tester);
        await tapDataOutputChip(tester, dataOutput: dataOutput);
        expectDataOutputSelected(tester, dataOutputSet);
        expect(CadScreen.cadBloc!.state.dataOutputSet, dataOutputSet);
        await verifyDataOutputQueryParameters(tester, dataOutputSet);
      }
      for (final dataOutput in CadScreen.dataOutputSet) {
        dataOutputSet.remove(dataOutput);
        await ensureDataOutputWidgetVisible(tester);
        await tapDataOutputChip(tester, dataOutput: dataOutput);
        expectDataOutputSelected(tester, dataOutputSet);
        expect(CadScreen.cadBloc!.state.dataOutputSet, dataOutputSet);
        await verifyDataOutputQueryParameters(tester, dataOutputSet);
      }
    });

    testWidgets('CadBloc prefilled ${DataOutput.fullname.name}',
        (tester) async {
      final cadBloc = getCadBloc();
      cadBloc.add(const CadDataOutputEvent(
        dataOutputSet: {DataOutput.fullname},
      ));
      await pumpCadRouteAsInitialLocation(tester, cadBloc: cadBloc);
      await ensureDataOutputWidgetVisible(tester);
      expect(tester.widget<FilterChip>(fullnameChipFinder).selected, true);
    });
  });
}
