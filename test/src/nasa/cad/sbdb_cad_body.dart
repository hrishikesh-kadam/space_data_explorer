import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

// LABEL: eligible-hrk_nasa_apis_test
JsonMap getSbdbCadBodyCountZeroJson() {
  return {
    'signature': {
      'version': SbdbCadApi.version,
      'source': SbdbCadApi.displayName,
    },
    'count': 0,
  };
}

SbdbCadBody getSbdbCadBodyCountZero() {
  return SbdbCadBody.fromJson(getSbdbCadBodyCountZeroJson());
}
