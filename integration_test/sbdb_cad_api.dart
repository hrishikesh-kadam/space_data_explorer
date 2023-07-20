import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'dio_response.dart';
// LABEL: eligible for hrk_nasa_apis_test
@GenerateNiceMocks([MockSpec<SbdbCadApi>()])
import 'sbdb_cad_api.mocks.dart';
import 'sbdb_cad_body.dart';

SbdbCadApi getMockedSbdbCadApi() {
  final Response<SbdbCadBody> response = getMockedDioResponse<SbdbCadBody>();
  when(response.data).thenReturn(getSbdbCadBodyCountZero());
  final SbdbCadApi sbdbCadApi = MockSbdbCadApi();
  when(sbdbCadApi.get()).thenAnswer((_) async => Future.value(response));
  when(sbdbCadApi.get(queryParameters: anyNamed('queryParameters')))
      .thenAnswer((_) async => Future.value(response));
  return sbdbCadApi;
}
