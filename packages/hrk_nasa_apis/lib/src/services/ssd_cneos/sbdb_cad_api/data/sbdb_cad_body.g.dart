// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sbdb_cad_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SbdbCad200Body _$$SbdbCad200BodyFromJson(Map<String, dynamic> json) =>
    _$SbdbCad200Body(
      signature: Signature.fromJson(json['signature'] as Map<String, dynamic>),
      count: json['count'] as int,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SbdbCadData.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SbdbCad200BodyToJson(_$SbdbCad200Body instance) =>
    <String, dynamic>{
      'signature': instance.signature,
      'count': instance.count,
      'data': instance.data,
      'runtimeType': instance.$type,
    };

_$SbdbCad400Body _$$SbdbCad400BodyFromJson(Map<String, dynamic> json) =>
    _$SbdbCad400Body(
      message: json['message'] as String,
      moreInfo: json['moreInfo'] as String,
      code: json['code'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SbdbCad400BodyToJson(_$SbdbCad400Body instance) =>
    <String, dynamic>{
      'message': instance.message,
      'moreInfo': instance.moreInfo,
      'code': instance.code,
      'runtimeType': instance.$type,
    };
