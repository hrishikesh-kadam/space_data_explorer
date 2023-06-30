// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sbdb_cad_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SbdbCad200Response _$$SbdbCad200ResponseFromJson(Map<String, dynamic> json) =>
    _$SbdbCad200Response(
      Signature.fromJson(json['signature'] as Map<String, dynamic>),
      json['count'] as int,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SbdbCad200ResponseToJson(
        _$SbdbCad200Response instance) =>
    <String, dynamic>{
      'signature': instance.signature,
      'count': instance.count,
      'runtimeType': instance.$type,
    };

_$SbdbCad400Response _$$SbdbCad400ResponseFromJson(Map<String, dynamic> json) =>
    _$SbdbCad400Response(
      json['message'] as String,
      json['moreInfo'] as String,
      json['code'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SbdbCad400ResponseToJson(
        _$SbdbCad400Response instance) =>
    <String, dynamic>{
      'message': instance.message,
      'moreInfo': instance.moreInfo,
      'code': instance.code,
      'runtimeType': instance.$type,
    };
