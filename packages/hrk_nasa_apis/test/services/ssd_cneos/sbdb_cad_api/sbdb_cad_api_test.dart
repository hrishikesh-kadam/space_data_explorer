import 'package:dio/dio.dart';
import 'package:hrk_nasa_apis/src/services/ssd_cneos/sbdb_cad_api/sbdb_cad_api.dart';
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
        Response response = await api.get();
        expect(200, response.statusCode);
      });
    });
  });
}
