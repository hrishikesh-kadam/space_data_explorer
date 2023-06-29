import 'package:dio/dio.dart';
import 'package:hrk_nasa_apis/src/services/ssd_cneos/sbdb_cad_api/sbdb_cad_response.dart';
import 'package:hrk_nasa_apis/src/services/ssd_cneos/sbdb_cad_api/sbdb_cad_transformer.dart';
import 'package:hrk_nasa_apis/src/services/ssd_cneos/ssd_cneos.dart';

class SbdbCadApi {
  SbdbCadApi({
    Dio? dio,
  }) {
    _dio = dio ?? Dio();
    _dio.options.baseUrl = SsdCneos.baseUrl.toString();
    _dio.transformer = SbdbCadTransformer();
    _dio.options.validateStatus = _validateStatus;
  }

  static final String path = 'cad.api';
  late final Dio _dio;

  bool _validateStatus(int? status) => status != null;

  Future<SbdbCadResponse> getDefault() async {
    final response = await _dio.get('/$path');
    return response.data;
  }

  Future<SbdbCadResponse> get({
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.get(
      '/$path',
      queryParameters: queryParameters,
    );
    return response.data;
  }
}
