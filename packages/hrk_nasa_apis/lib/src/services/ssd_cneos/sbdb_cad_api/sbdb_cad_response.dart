import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hrk_nasa_apis/src/services/ssd_cneos/signature.dart';

part 'sbdb_cad_response.freezed.dart';
part 'sbdb_cad_response.g.dart';

@freezed
class SbdbCadResponse with _$SbdbCadResponse {
  factory SbdbCadResponse.two00(
    Signature signature,
    int count,
  ) = SbdbCad200Response;

  factory SbdbCadResponse.four00(
    String message,
    String moreInfo,
    String code,
  ) = SbdbCad400Response;

  factory SbdbCadResponse.fromJson(Map<String, dynamic> json) =>
      _$SbdbCadResponseFromJson(json);
}
