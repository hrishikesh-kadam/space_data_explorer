import 'package:dio/dio.dart';
import 'package:hrk_nasa_apis/src/services/ssd_cneos/ssd_cneos.dart';

class SbdbCadApi {
  SbdbCadApi({
    Dio? dio,
  }) {
    _dio = dio ??
        Dio(
          BaseOptions(
            baseUrl: SsdCneos.baseUrl.toString(),
          ),
        );
  }

  static final String path = 'cad.api';
  late final Dio _dio;

  Future<Response> get() async {
    return await _dio.get('/$path');
  }
}
