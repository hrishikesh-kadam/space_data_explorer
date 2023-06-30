// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/signature.dart';
import 'sbdb_cad_data.dart';

part 'sbdb_cad_body.freezed.dart';
part 'sbdb_cad_body.g.dart';

@freezed
class SbdbCadBody with _$SbdbCadBody {
  factory SbdbCadBody.two00({
    required Signature signature,
    required int count,
    required List<SbdbCadData>? data,
  }) = SbdbCad200Body;

  factory SbdbCadBody.four00({
    required String message,
    @JsonKey(name: 'moreInfo') required String moreInfo,
    required String code,
  }) = SbdbCad400Body;

  factory SbdbCadBody.fromJson(Map<String, dynamic> json) =>
      _$SbdbCadBodyFromJson(json);
}
