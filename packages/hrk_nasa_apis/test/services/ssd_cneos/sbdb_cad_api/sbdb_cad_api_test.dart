import 'package:dio/dio.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:hrk_nasa_apis/src/services/ssd_cneos/sbdb_cad_api/data/sbdb_cad_body.dart';
import 'package:hrk_nasa_apis/src/services/ssd_cneos/sbdb_cad_api/sbdb_cad_api.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('SbdbCadApi', () {
    late SbdbCadApi api;
    late Logger log;

    setUpAll(() {
      configureHrkLogging();
      log = Logger('$SbdbCadApi.Test')..level = Level.ALL;
    });

    setUp(() {
      api = SbdbCadApi();
    });

    group('get', () {
      group('200', () {
        test('default', () async {
          Response<SbdbCadBody> response = await api.get();
          expect(response.data, isA<SbdbCad200Body>());
          final sbdbCad200Body = response.data as SbdbCad200Body;
          if (sbdbCad200Body.signature.version != SbdbCadApi.version) {
            String message =
                '${SbdbCadApi.displayName} version is now ${sbdbCad200Body.signature.version}'
                ', tested on ${SbdbCadApi.version}'
                ', See ${SbdbCadApi.docUrl}';
            log.warning(message);
          }
          if (sbdbCad200Body.count <= 0) {
            expect(sbdbCad200Body.data, isNull);
          } else {
            expect(sbdbCad200Body.data, isNotNull);
            expect(sbdbCad200Body.data!.first.fullname, isNull);
            expect(sbdbCad200Body.data!.first.body, isNull);
            expect(sbdbCad200Body.data!.first.diameter, isNull);
            expect(sbdbCad200Body.data!.first.diameterSigma, isNull);
          }
        });

        test('fullname', () async {
          Response<SbdbCadBody> response = await api.get(
            queryParameters: {
              'fullname': true,
            },
          );
          expect(response.data, isA<SbdbCad200Body>());
          final sbdbCad200Body = response.data as SbdbCad200Body;
          if (sbdbCad200Body.count > 0) {
            expect(sbdbCad200Body.data!.first.fullname, isNotNull);
          }
        });

        test('body', () async {
          Response<SbdbCadBody> response = await api.get(
            queryParameters: {
              'body': 'ALL',
            },
          );
          expect(response.data, isA<SbdbCad200Body>());
          final sbdbCad200Body = response.data as SbdbCad200Body;
          if (sbdbCad200Body.count > 0) {
            expect(sbdbCad200Body.data!.first.body, isNotNull);
          }
        });
      });

      test('400', () async {
        Response<SbdbCadBody> response = await api.get(
          queryParameters: {
            'body': 'Pandora',
          },
        );
        expect(response.data, isA<SbdbCad400Body>());
        final sbdbCad400Body = response.data as SbdbCad400Body;
        expect(sbdbCad400Body.code, '400');
      });

      test('404', () async {
        try {
          // ignore: unused_local_variable
          Response<SbdbCadBody> response = await api.four04();
        } on DioException catch (e) {
          expect(e.response!.statusCode, 404);
        }
      });
    });
  });
}
