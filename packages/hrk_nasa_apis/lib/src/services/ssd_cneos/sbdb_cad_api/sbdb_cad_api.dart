import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utility/utility.dart';
import '../ssd_cneos.dart';
import 'data/sbdb_cad_body.dart';
import 'sbdb_cad_transformer.dart';

/// https://www.postman.com/hrishikesh-kadam/workspace/nasa-open-apis/collection/2540023-c2b59b2b-8b9c-40da-81c0-10f725fec38a
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

  static final Uri url = Uri(
    scheme: SsdCneos.baseUrl.scheme,
    host: SsdCneos.baseUrl.host,
    path: 'cad.api',
  );
  static final Uri docUrl = Uri(
    scheme: SsdCneos.baseUrl.scheme,
    host: SsdCneos.baseUrl.host,
    path: 'doc/cad.html',
  );
  static const String displayName = 'SBDB Close-Approach Data API';
  static const String version = '1.5';
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
      '/${url.path}',
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
