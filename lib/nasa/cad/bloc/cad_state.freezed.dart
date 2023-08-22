// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cad_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CadState {
  DateTimeRange? get dateRange => throw _privateConstructorUsedError;
  ValueRange<double, DistanceUnit> get distRange =>
      throw _privateConstructorUsedError;
  ValueRange<String, Never> get distRangeText =>
      throw _privateConstructorUsedError;
  SmallBodyState get smallBodyState => throw _privateConstructorUsedError;
  SmallBodySelectorState get smallBodySelectorState =>
      throw _privateConstructorUsedError;
  CloseApproachBody get closeApproachBody => throw _privateConstructorUsedError;
  Set<DataOutput> get dataOutputSet => throw _privateConstructorUsedError;
  NetworkState get networkState => throw _privateConstructorUsedError;
  SbdbCadBody? get sbdbCadBody => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CadStateCopyWith<CadState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CadStateCopyWith<$Res> {
  factory $CadStateCopyWith(CadState value, $Res Function(CadState) then) =
      _$CadStateCopyWithImpl<$Res, CadState>;
  @useResult
  $Res call(
      {DateTimeRange? dateRange,
      ValueRange<double, DistanceUnit> distRange,
      ValueRange<String, Never> distRangeText,
      SmallBodyState smallBodyState,
      SmallBodySelectorState smallBodySelectorState,
      CloseApproachBody closeApproachBody,
      Set<DataOutput> dataOutputSet,
      NetworkState networkState,
      SbdbCadBody? sbdbCadBody});

  $ValueRangeCopyWith<double, DistanceUnit, $Res> get distRange;
  $ValueRangeCopyWith<String, Never, $Res> get distRangeText;
  $SmallBodyStateCopyWith<$Res> get smallBodyState;
  $SmallBodySelectorStateCopyWith<$Res> get smallBodySelectorState;
  $SbdbCadBodyCopyWith<$Res>? get sbdbCadBody;
}

/// @nodoc
class _$CadStateCopyWithImpl<$Res, $Val extends CadState>
    implements $CadStateCopyWith<$Res> {
  _$CadStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateRange = freezed,
    Object? distRange = null,
    Object? distRangeText = null,
    Object? smallBodyState = null,
    Object? smallBodySelectorState = null,
    Object? closeApproachBody = null,
    Object? dataOutputSet = null,
    Object? networkState = null,
    Object? sbdbCadBody = freezed,
  }) {
    return _then(_value.copyWith(
      dateRange: freezed == dateRange
          ? _value.dateRange
          : dateRange // ignore: cast_nullable_to_non_nullable
              as DateTimeRange?,
      distRange: null == distRange
          ? _value.distRange
          : distRange // ignore: cast_nullable_to_non_nullable
              as ValueRange<double, DistanceUnit>,
      distRangeText: null == distRangeText
          ? _value.distRangeText
          : distRangeText // ignore: cast_nullable_to_non_nullable
              as ValueRange<String, Never>,
      smallBodyState: null == smallBodyState
          ? _value.smallBodyState
          : smallBodyState // ignore: cast_nullable_to_non_nullable
              as SmallBodyState,
      smallBodySelectorState: null == smallBodySelectorState
          ? _value.smallBodySelectorState
          : smallBodySelectorState // ignore: cast_nullable_to_non_nullable
              as SmallBodySelectorState,
      closeApproachBody: null == closeApproachBody
          ? _value.closeApproachBody
          : closeApproachBody // ignore: cast_nullable_to_non_nullable
              as CloseApproachBody,
      dataOutputSet: null == dataOutputSet
          ? _value.dataOutputSet
          : dataOutputSet // ignore: cast_nullable_to_non_nullable
              as Set<DataOutput>,
      networkState: null == networkState
          ? _value.networkState
          : networkState // ignore: cast_nullable_to_non_nullable
              as NetworkState,
      sbdbCadBody: freezed == sbdbCadBody
          ? _value.sbdbCadBody
          : sbdbCadBody // ignore: cast_nullable_to_non_nullable
              as SbdbCadBody?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ValueRangeCopyWith<double, DistanceUnit, $Res> get distRange {
    return $ValueRangeCopyWith<double, DistanceUnit, $Res>(_value.distRange,
        (value) {
      return _then(_value.copyWith(distRange: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ValueRangeCopyWith<String, Never, $Res> get distRangeText {
    return $ValueRangeCopyWith<String, Never, $Res>(_value.distRangeText,
        (value) {
      return _then(_value.copyWith(distRangeText: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SmallBodyStateCopyWith<$Res> get smallBodyState {
    return $SmallBodyStateCopyWith<$Res>(_value.smallBodyState, (value) {
      return _then(_value.copyWith(smallBodyState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SmallBodySelectorStateCopyWith<$Res> get smallBodySelectorState {
    return $SmallBodySelectorStateCopyWith<$Res>(_value.smallBodySelectorState,
        (value) {
      return _then(_value.copyWith(smallBodySelectorState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SbdbCadBodyCopyWith<$Res>? get sbdbCadBody {
    if (_value.sbdbCadBody == null) {
      return null;
    }

    return $SbdbCadBodyCopyWith<$Res>(_value.sbdbCadBody!, (value) {
      return _then(_value.copyWith(sbdbCadBody: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CadStateCopyWith<$Res> implements $CadStateCopyWith<$Res> {
  factory _$$_CadStateCopyWith(
          _$_CadState value, $Res Function(_$_CadState) then) =
      __$$_CadStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTimeRange? dateRange,
      ValueRange<double, DistanceUnit> distRange,
      ValueRange<String, Never> distRangeText,
      SmallBodyState smallBodyState,
      SmallBodySelectorState smallBodySelectorState,
      CloseApproachBody closeApproachBody,
      Set<DataOutput> dataOutputSet,
      NetworkState networkState,
      SbdbCadBody? sbdbCadBody});

  @override
  $ValueRangeCopyWith<double, DistanceUnit, $Res> get distRange;
  @override
  $ValueRangeCopyWith<String, Never, $Res> get distRangeText;
  @override
  $SmallBodyStateCopyWith<$Res> get smallBodyState;
  @override
  $SmallBodySelectorStateCopyWith<$Res> get smallBodySelectorState;
  @override
  $SbdbCadBodyCopyWith<$Res>? get sbdbCadBody;
}

/// @nodoc
class __$$_CadStateCopyWithImpl<$Res>
    extends _$CadStateCopyWithImpl<$Res, _$_CadState>
    implements _$$_CadStateCopyWith<$Res> {
  __$$_CadStateCopyWithImpl(
      _$_CadState _value, $Res Function(_$_CadState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateRange = freezed,
    Object? distRange = null,
    Object? distRangeText = null,
    Object? smallBodyState = null,
    Object? smallBodySelectorState = null,
    Object? closeApproachBody = null,
    Object? dataOutputSet = null,
    Object? networkState = null,
    Object? sbdbCadBody = freezed,
  }) {
    return _then(_$_CadState(
      dateRange: freezed == dateRange
          ? _value.dateRange
          : dateRange // ignore: cast_nullable_to_non_nullable
              as DateTimeRange?,
      distRange: null == distRange
          ? _value.distRange
          : distRange // ignore: cast_nullable_to_non_nullable
              as ValueRange<double, DistanceUnit>,
      distRangeText: null == distRangeText
          ? _value.distRangeText
          : distRangeText // ignore: cast_nullable_to_non_nullable
              as ValueRange<String, Never>,
      smallBodyState: null == smallBodyState
          ? _value.smallBodyState
          : smallBodyState // ignore: cast_nullable_to_non_nullable
              as SmallBodyState,
      smallBodySelectorState: null == smallBodySelectorState
          ? _value.smallBodySelectorState
          : smallBodySelectorState // ignore: cast_nullable_to_non_nullable
              as SmallBodySelectorState,
      closeApproachBody: null == closeApproachBody
          ? _value.closeApproachBody
          : closeApproachBody // ignore: cast_nullable_to_non_nullable
              as CloseApproachBody,
      dataOutputSet: null == dataOutputSet
          ? _value._dataOutputSet
          : dataOutputSet // ignore: cast_nullable_to_non_nullable
              as Set<DataOutput>,
      networkState: null == networkState
          ? _value.networkState
          : networkState // ignore: cast_nullable_to_non_nullable
              as NetworkState,
      sbdbCadBody: freezed == sbdbCadBody
          ? _value.sbdbCadBody
          : sbdbCadBody // ignore: cast_nullable_to_non_nullable
              as SbdbCadBody?,
    ));
  }
}

/// @nodoc

class _$_CadState implements _CadState {
  const _$_CadState(
      {this.dateRange,
      this.distRange = distRangeDefault,
      this.distRangeText = const ValueRange<String, Never>(
          start: ValueUnit<String, Never>(value: ''),
          end: ValueUnit<String, Never>(value: '')),
      this.smallBodyState = const SmallBodyState(),
      this.smallBodySelectorState = const SmallBodySelectorState(),
      this.closeApproachBody = SbdbCadQueryParameters.closeApproachBodyDefault,
      final Set<DataOutput> dataOutputSet = const {},
      this.networkState = NetworkState.initial,
      this.sbdbCadBody})
      : _dataOutputSet = dataOutputSet;

  @override
  final DateTimeRange? dateRange;
  @override
  @JsonKey()
  final ValueRange<double, DistanceUnit> distRange;
  @override
  @JsonKey()
  final ValueRange<String, Never> distRangeText;
  @override
  @JsonKey()
  final SmallBodyState smallBodyState;
  @override
  @JsonKey()
  final SmallBodySelectorState smallBodySelectorState;
  @override
  @JsonKey()
  final CloseApproachBody closeApproachBody;
  final Set<DataOutput> _dataOutputSet;
  @override
  @JsonKey()
  Set<DataOutput> get dataOutputSet {
    if (_dataOutputSet is EqualUnmodifiableSetView) return _dataOutputSet;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_dataOutputSet);
  }

  @override
  @JsonKey()
  final NetworkState networkState;
  @override
  final SbdbCadBody? sbdbCadBody;

  @override
  String toString() {
    return 'CadState(dateRange: $dateRange, distRange: $distRange, distRangeText: $distRangeText, smallBodyState: $smallBodyState, smallBodySelectorState: $smallBodySelectorState, closeApproachBody: $closeApproachBody, dataOutputSet: $dataOutputSet, networkState: $networkState, sbdbCadBody: $sbdbCadBody)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CadState &&
            (identical(other.dateRange, dateRange) ||
                other.dateRange == dateRange) &&
            (identical(other.distRange, distRange) ||
                other.distRange == distRange) &&
            (identical(other.distRangeText, distRangeText) ||
                other.distRangeText == distRangeText) &&
            (identical(other.smallBodyState, smallBodyState) ||
                other.smallBodyState == smallBodyState) &&
            (identical(other.smallBodySelectorState, smallBodySelectorState) ||
                other.smallBodySelectorState == smallBodySelectorState) &&
            (identical(other.closeApproachBody, closeApproachBody) ||
                other.closeApproachBody == closeApproachBody) &&
            const DeepCollectionEquality()
                .equals(other._dataOutputSet, _dataOutputSet) &&
            (identical(other.networkState, networkState) ||
                other.networkState == networkState) &&
            (identical(other.sbdbCadBody, sbdbCadBody) ||
                other.sbdbCadBody == sbdbCadBody));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      dateRange,
      distRange,
      distRangeText,
      smallBodyState,
      smallBodySelectorState,
      closeApproachBody,
      const DeepCollectionEquality().hash(_dataOutputSet),
      networkState,
      sbdbCadBody);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CadStateCopyWith<_$_CadState> get copyWith =>
      __$$_CadStateCopyWithImpl<_$_CadState>(this, _$identity);
}

abstract class _CadState implements CadState {
  const factory _CadState(
      {final DateTimeRange? dateRange,
      final ValueRange<double, DistanceUnit> distRange,
      final ValueRange<String, Never> distRangeText,
      final SmallBodyState smallBodyState,
      final SmallBodySelectorState smallBodySelectorState,
      final CloseApproachBody closeApproachBody,
      final Set<DataOutput> dataOutputSet,
      final NetworkState networkState,
      final SbdbCadBody? sbdbCadBody}) = _$_CadState;

  @override
  DateTimeRange? get dateRange;
  @override
  ValueRange<double, DistanceUnit> get distRange;
  @override
  ValueRange<String, Never> get distRangeText;
  @override
  SmallBodyState get smallBodyState;
  @override
  SmallBodySelectorState get smallBodySelectorState;
  @override
  CloseApproachBody get closeApproachBody;
  @override
  Set<DataOutput> get dataOutputSet;
  @override
  NetworkState get networkState;
  @override
  SbdbCadBody? get sbdbCadBody;
  @override
  @JsonKey(ignore: true)
  _$$_CadStateCopyWith<_$_CadState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SmallBodyState {
  bool get enabled => throw _privateConstructorUsedError;
  SmallBody get smallBody => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SmallBodyStateCopyWith<SmallBodyState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmallBodyStateCopyWith<$Res> {
  factory $SmallBodyStateCopyWith(
          SmallBodyState value, $Res Function(SmallBodyState) then) =
      _$SmallBodyStateCopyWithImpl<$Res, SmallBodyState>;
  @useResult
  $Res call({bool enabled, SmallBody smallBody});
}

/// @nodoc
class _$SmallBodyStateCopyWithImpl<$Res, $Val extends SmallBodyState>
    implements $SmallBodyStateCopyWith<$Res> {
  _$SmallBodyStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? smallBody = null,
  }) {
    return _then(_value.copyWith(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      smallBody: null == smallBody
          ? _value.smallBody
          : smallBody // ignore: cast_nullable_to_non_nullable
              as SmallBody,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SmallBodyStateCopyWith<$Res>
    implements $SmallBodyStateCopyWith<$Res> {
  factory _$$_SmallBodyStateCopyWith(
          _$_SmallBodyState value, $Res Function(_$_SmallBodyState) then) =
      __$$_SmallBodyStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool enabled, SmallBody smallBody});
}

/// @nodoc
class __$$_SmallBodyStateCopyWithImpl<$Res>
    extends _$SmallBodyStateCopyWithImpl<$Res, _$_SmallBodyState>
    implements _$$_SmallBodyStateCopyWith<$Res> {
  __$$_SmallBodyStateCopyWithImpl(
      _$_SmallBodyState _value, $Res Function(_$_SmallBodyState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? smallBody = null,
  }) {
    return _then(_$_SmallBodyState(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      smallBody: null == smallBody
          ? _value.smallBody
          : smallBody // ignore: cast_nullable_to_non_nullable
              as SmallBody,
    ));
  }
}

/// @nodoc

class _$_SmallBodyState implements _SmallBodyState {
  const _$_SmallBodyState(
      {this.enabled = true,
      this.smallBody = SbdbCadQueryParameters.smallBodyDefault});

  @override
  @JsonKey()
  final bool enabled;
  @override
  @JsonKey()
  final SmallBody smallBody;

  @override
  String toString() {
    return 'SmallBodyState(enabled: $enabled, smallBody: $smallBody)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SmallBodyState &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.smallBody, smallBody) ||
                other.smallBody == smallBody));
  }

  @override
  int get hashCode => Object.hash(runtimeType, enabled, smallBody);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SmallBodyStateCopyWith<_$_SmallBodyState> get copyWith =>
      __$$_SmallBodyStateCopyWithImpl<_$_SmallBodyState>(this, _$identity);
}

abstract class _SmallBodyState implements SmallBodyState {
  const factory _SmallBodyState(
      {final bool enabled, final SmallBody smallBody}) = _$_SmallBodyState;

  @override
  bool get enabled;
  @override
  SmallBody get smallBody;
  @override
  @JsonKey(ignore: true)
  _$$_SmallBodyStateCopyWith<_$_SmallBodyState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SmallBodySelectorState {
  SmallBodySelector? get smallBodySelector =>
      throw _privateConstructorUsedError;
  int? get spkId => throw _privateConstructorUsedError;
  String? get designation => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SmallBodySelectorStateCopyWith<SmallBodySelectorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmallBodySelectorStateCopyWith<$Res> {
  factory $SmallBodySelectorStateCopyWith(SmallBodySelectorState value,
          $Res Function(SmallBodySelectorState) then) =
      _$SmallBodySelectorStateCopyWithImpl<$Res, SmallBodySelectorState>;
  @useResult
  $Res call(
      {SmallBodySelector? smallBodySelector, int? spkId, String? designation});
}

/// @nodoc
class _$SmallBodySelectorStateCopyWithImpl<$Res,
        $Val extends SmallBodySelectorState>
    implements $SmallBodySelectorStateCopyWith<$Res> {
  _$SmallBodySelectorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? smallBodySelector = freezed,
    Object? spkId = freezed,
    Object? designation = freezed,
  }) {
    return _then(_value.copyWith(
      smallBodySelector: freezed == smallBodySelector
          ? _value.smallBodySelector
          : smallBodySelector // ignore: cast_nullable_to_non_nullable
              as SmallBodySelector?,
      spkId: freezed == spkId
          ? _value.spkId
          : spkId // ignore: cast_nullable_to_non_nullable
              as int?,
      designation: freezed == designation
          ? _value.designation
          : designation // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SmallBodySelectorStateCopyWith<$Res>
    implements $SmallBodySelectorStateCopyWith<$Res> {
  factory _$$_SmallBodySelectorStateCopyWith(_$_SmallBodySelectorState value,
          $Res Function(_$_SmallBodySelectorState) then) =
      __$$_SmallBodySelectorStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SmallBodySelector? smallBodySelector, int? spkId, String? designation});
}

/// @nodoc
class __$$_SmallBodySelectorStateCopyWithImpl<$Res>
    extends _$SmallBodySelectorStateCopyWithImpl<$Res,
        _$_SmallBodySelectorState>
    implements _$$_SmallBodySelectorStateCopyWith<$Res> {
  __$$_SmallBodySelectorStateCopyWithImpl(_$_SmallBodySelectorState _value,
      $Res Function(_$_SmallBodySelectorState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? smallBodySelector = freezed,
    Object? spkId = freezed,
    Object? designation = freezed,
  }) {
    return _then(_$_SmallBodySelectorState(
      smallBodySelector: freezed == smallBodySelector
          ? _value.smallBodySelector
          : smallBodySelector // ignore: cast_nullable_to_non_nullable
              as SmallBodySelector?,
      spkId: freezed == spkId
          ? _value.spkId
          : spkId // ignore: cast_nullable_to_non_nullable
              as int?,
      designation: freezed == designation
          ? _value.designation
          : designation // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_SmallBodySelectorState implements _SmallBodySelectorState {
  const _$_SmallBodySelectorState(
      {this.smallBodySelector, this.spkId, this.designation});

  @override
  final SmallBodySelector? smallBodySelector;
  @override
  final int? spkId;
  @override
  final String? designation;

  @override
  String toString() {
    return 'SmallBodySelectorState(smallBodySelector: $smallBodySelector, spkId: $spkId, designation: $designation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SmallBodySelectorState &&
            (identical(other.smallBodySelector, smallBodySelector) ||
                other.smallBodySelector == smallBodySelector) &&
            (identical(other.spkId, spkId) || other.spkId == spkId) &&
            (identical(other.designation, designation) ||
                other.designation == designation));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, smallBodySelector, spkId, designation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SmallBodySelectorStateCopyWith<_$_SmallBodySelectorState> get copyWith =>
      __$$_SmallBodySelectorStateCopyWithImpl<_$_SmallBodySelectorState>(
          this, _$identity);
}

abstract class _SmallBodySelectorState implements SmallBodySelectorState {
  const factory _SmallBodySelectorState(
      {final SmallBodySelector? smallBodySelector,
      final int? spkId,
      final String? designation}) = _$_SmallBodySelectorState;

  @override
  SmallBodySelector? get smallBodySelector;
  @override
  int? get spkId;
  @override
  String? get designation;
  @override
  @JsonKey(ignore: true)
  _$$_SmallBodySelectorStateCopyWith<_$_SmallBodySelectorState> get copyWith =>
      throw _privateConstructorUsedError;
}
