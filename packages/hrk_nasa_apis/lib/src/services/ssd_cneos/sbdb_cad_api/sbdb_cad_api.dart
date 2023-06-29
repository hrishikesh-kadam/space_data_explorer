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

  late final Dio _dio;

  Future<void> get() async {
    await _dio.get('');
  }
}
