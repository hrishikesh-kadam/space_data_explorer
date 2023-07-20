import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

SbdbCadBody getSbdbCadBodyCountZero() {
  final json = {
    'signature': {
      'version': SbdbCadApi.version,
      'source': SbdbCadApi.displayName,
    },
    'count': 0,
  };
  return SbdbCadBody.fromJson(json);
}
