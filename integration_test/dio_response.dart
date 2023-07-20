import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';
import 'package:mockito/annotations.dart';

// LABEL: eligible for hrk_nasa_apis_test
@GenerateNiceMocks([MockSpec<Response>()])
import 'dio_response.mocks.dart';

Response<T> getMockedDioResponse<T>() {
  return MockResponse<T>();
}
