import 'package:dio/dio.dart';
import 'package:hrk_nasa_apis/src/services/ssd_cneos/sbdb_cad_api/sbdb_cad_response.dart';
import 'package:hrk_nasa_apis/src/utility/utility.dart';

class SbdbCadTransformer extends BackgroundTransformer {
  @override
  Future<SbdbCadResponse> transformResponse(
      RequestOptions options, ResponseBody response) async {
    final Map<String, dynamic> json =
        await super.transformResponse(options, response);
    setFreezedRuntimeType(response.statusCode, json);
    return SbdbCadResponse.fromJson(json);
  }
}
