import 'package:dio/dio.dart';
import 'package:hrk_nasa_apis/src/jpl_nasa.dart';

class SsdCneos {
  static final Uri baseUrl = Uri(
    scheme: 'https',
    host: 'ssd-api.${JplNasa.domain}',
  );
  static final BaseOptions dioBaseOptions = BaseOptions(
    baseUrl: baseUrl.toString(),
  );
}
