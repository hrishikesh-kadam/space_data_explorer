import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';
import 'package:recase/recase.dart';

import 'package:space_data_explorer/nasa/cad_result/cad_result_screen.dart';
import '../../../src/globals.dart';

void main() {
  group('$CadResultScreen', () {
    test('getLocalizedBody()', () {
      for (final body in CloseApproachBody.values) {
        final expectedBody = body.name.sentenceCase;
        expect(
          CadResultScreen.getLocalizedBody(
            body: body.name.sentenceCase,
            l10n: l10n,
          ),
          expectedBody,
        );
      }
    });
  });
}
