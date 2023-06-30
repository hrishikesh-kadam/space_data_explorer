import 'package:dio/dio.dart';
import 'package:hrk_nasa_apis/src/services/ssd_cneos/sbdb_cad_api/sbdb_cad_api.dart';
import 'package:hrk_nasa_apis/src/utility/utility.dart';

class SbdbCadTransformer extends BackgroundTransformer {
  @override
  Future<dynamic> transformResponse(
    RequestOptions options,
    ResponseBody response,
  ) async {
    final transformedResponse = await super.transformResponse(
      options,
      response,
    );
    final serializableMap = SbdbCadApi.serializableMap;
    if (serializableMap.keys.contains(response.statusCode)) {
      final json = transformedResponse as JsonMap;
      FromJsonFunction fromJsonFunction = serializableMap[response.statusCode]!;
      return fromJsonFunction(json);
    }
    return transformResponse;
  }
}
