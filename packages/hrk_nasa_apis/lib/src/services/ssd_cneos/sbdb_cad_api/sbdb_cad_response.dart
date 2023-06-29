import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hrk_nasa_apis/src/services/ssd_cneos/signature.dart';

part 'sbdb_cad_response.freezed.dart';
part 'sbdb_cad_response.g.dart';

@freezed
class SbdbCadResponse with _$SbdbCadResponse {
  factory SbdbCadResponse.twoxx(
    Signature signature,
    int count,
  ) = SbdbCad2xxResponse;

  factory SbdbCadResponse.fourxx(
    String message,
    String moreInfo,
    String code,
  ) = SbdbCad4xxResponse;

  factory SbdbCadResponse.fromJson(Map<String, dynamic> json) =>
      _$SbdbCadResponseFromJson(json);
}
