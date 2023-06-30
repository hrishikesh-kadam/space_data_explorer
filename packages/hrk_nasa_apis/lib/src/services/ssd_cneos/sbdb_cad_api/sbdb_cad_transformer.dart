import 'package:dio/dio.dart';

import '../../../utility/utility.dart';
import 'sbdb_cad_api.dart';

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
      var json = transformedResponse as JsonMap;
      if (response.statusCode == 200) {
        json = transform200Response(json);
      }
      FromJsonFunction fromJsonFunction = serializableMap[response.statusCode]!;
      return fromJsonFunction(json);
    }
    return transformResponse;
  }

  JsonMap transform200Response(JsonMap json) {
    if (json['count'] <= 0) {
      return json;
    }
    final transformedJson = JsonMap.from(json);
    transformedJson.remove('fields');
    transformedJson.remove('data');
    transformedJson['data'] = <JsonMap>[];
    List<dynamic> fields = json['fields'];
    List<dynamic> dataList = json['data'];

    for (int i = 0; i < dataList.length; i++) {
      List<dynamic> data = dataList[i];
      JsonMap dataMap = {};
      for (int j = 0; j < data.length; j++) {
        dataMap[fields[j]] = data[j];
      }
      List<JsonMap> transformedDataList = transformedJson['data'];
      transformedDataList.add(dataMap);
    }
    return transformedJson;
  }
}
