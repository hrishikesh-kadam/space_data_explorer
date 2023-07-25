// ignore_for_file: constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

enum DateFormatPattern {
  @JsonValue('yMd')
  yMd(pattern: 'yMd'),
  @JsonValue('dd/MM/yyyy')
  ddMMyyyy(pattern: 'dd/MM/yyyy'),
  @JsonValue('MM/dd/yyyy')
  MMddyyyy(pattern: 'MM/dd/yyyy'),
  @JsonValue('yyyy/MM/dd')
  yyyyMMdd(pattern: 'yyyy/MM/dd');

  const DateFormatPattern({
    required this.pattern,
  });

  final String pattern;
}
