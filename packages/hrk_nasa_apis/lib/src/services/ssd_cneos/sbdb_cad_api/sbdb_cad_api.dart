import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hrk_nasa_apis/src/services/ssd_cneos/sbdb_cad_api/data/sbdb_cad_body.dart';
import 'package:hrk_nasa_apis/src/services/ssd_cneos/sbdb_cad_api/sbdb_cad_transformer.dart';
import 'package:hrk_nasa_apis/src/services/ssd_cneos/ssd_cneos.dart';
import 'package:hrk_nasa_apis/src/utility/utility.dart';

class SbdbCadApi {
  SbdbCadApi({
    Dio? dio,
  }) {
    _dio = dio ?? getDefaultDio();
  }

  static Dio getDefaultDio() {
    return Dio()
      ..options = SsdCneos.dioBaseOptions
      ..options.validateStatus = _validateStatus
      ..transformer = SbdbCadTransformer();
  }

  static const String path = 'cad.api';
  late final Dio _dio;
  // TODO(hrishikesh-kadam): File a feature request
  static const Map<int, FromJsonFunction> serializableMap = {
    200: SbdbCad200Body.fromJson,
    400: SbdbCad400Body.fromJson,
  };

  static bool _validateStatus(int? status) {
    return serializableMap.keys.contains(status);
  }

  Future<Response<SbdbCadBody>> get({
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.get(
      '/$path',
      queryParameters: queryParameters,
    );
  }

  @visibleForTesting
  Future<Response<SbdbCadBody>> four04({
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.get(
      '/cad.ap',
      queryParameters: queryParameters,
    );
  }
}
