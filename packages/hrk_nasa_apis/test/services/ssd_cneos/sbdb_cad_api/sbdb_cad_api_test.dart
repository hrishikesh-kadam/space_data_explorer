import 'package:hrk_nasa_apis/src/services/ssd_cneos/sbdb_cad_api/sbdb_cad_api.dart';
import 'package:hrk_nasa_apis/src/services/ssd_cneos/sbdb_cad_api/sbdb_cad_response.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('SbdbCadApi', () {
    late SbdbCadApi api;

    setUp(() {
      api = SbdbCadApi();
    });

    group('get', () {
      test('default', () async {
        SbdbCadResponse response = await api.getDefault();
        expect(response, isA<SbdbCad2xxResponse>());
        response = response as SbdbCad2xxResponse;
        expect('1.5', response.signature.version);
      });

      test('body=check', () async {
        Map<String, dynamic> queryParameters = {
          'body': 'check',
        };
        SbdbCadResponse response =
            await api.get(queryParameters: queryParameters);
        expect(response, isA<SbdbCad4xxResponse>());
        response = response as SbdbCad4xxResponse;
        expect('400', response.code);
      });
    });
  });
}
