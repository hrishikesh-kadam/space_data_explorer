import 'package:hrk_nasa_apis/src/extension/http_response_status_code.dart';

void setFreezedRuntimeType(int statusCode, Map<String, dynamic> json) {
  if (statusCode.is2xx()) {
    json['runtimeType'] = 'twoxx';
  } else if (statusCode.is3xx()) {
    json['runtimeType'] = 'threexx';
  } else if (statusCode.is4xx()) {
    json['runtimeType'] = 'fourxx';
  } else {
    throw Exception(
        'Freezed runtimeType cannot be evaluated for $statusCode statusCode');
  }
}
