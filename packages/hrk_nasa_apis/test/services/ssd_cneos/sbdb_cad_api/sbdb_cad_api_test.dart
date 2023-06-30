import 'package:dio/dio.dart';
import 'package:hrk_nasa_apis/src/services/ssd_cneos/sbdb_cad_api/sbdb_cad_api.dart';
import 'package:hrk_nasa_apis/src/services/ssd_cneos/sbdb_cad_api/data/sbdb_cad_data.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('SbdbCadApi', () {
    late SbdbCadApi api;

    setUp(() {
      api = SbdbCadApi();
    });

    group('get', () {
      test('200', () async {
        Response<SbdbCadData> response = await api.get();
        expect(response.data, isA<SbdbCad200Data>());
        final sbdbCad200Data = response.data as SbdbCad200Data;
        expect(sbdbCad200Data.signature.version, '1.5');
      });

      test('400', () async {
        Response<SbdbCadData> response = await api.get(
          queryParameters: {
            'body': 'Pandora',
          },
        );
        expect(response.data, isA<SbdbCad400Data>());
        final sbdbCad400Data = response.data as SbdbCad400Data;
        expect(sbdbCad400Data.code, '400');
      });

      test('404', () async {
        try {
          // ignore: unused_local_variable
          Response<SbdbCadData> response = await api.four04();
        } on DioException catch (e) {
          expect(e.response!.statusCode, 404);
        }
      });
    });
  });
}