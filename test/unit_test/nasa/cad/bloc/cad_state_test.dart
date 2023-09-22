import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';
import 'package:space_data_explorer/nasa/cad/bloc/cad_state.dart';

void main() {
  group('$DistanceRangeState', () {
    test('Coverage false positive', () {
      expect(DistanceRangeState.valueListDefault[0], null);
      expect(DistanceRangeState.textListDefault[0], '');
      expect(
        DistanceRangeState.unitListDefault[0],
        SbdbCadQueryParameters.distUnitDefault,
      );
    });
  });
}
