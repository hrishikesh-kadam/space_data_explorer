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
  DistanceRangeState get distanceRangeState =>
      throw _privateConstructorUsedError;
  SmallBodyFilterState get smallBodyFilterState =>
      throw _privateConstructorUsedError;
  SmallBodySelectorState get smallBodySelectorState =>
      throw _privateConstructorUsedError;
  CloseApproachBody get closeApproachBody => throw _privateConstructorUsedError;
  Set<DataOutput> get dataOutputSet => throw _privateConstructorUsedError;
  NetworkState get networkState => throw _privateConstructorUsedError;
  CancelToken? get cancelToken => throw _privateConstructorUsedError;
  bool get disableInputs => throw _privateConstructorUsedError;
  SbdbCadBody? get sbdbCadBody => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;

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
      DistanceRangeState distanceRangeState,
      SmallBodyFilterState smallBodyFilterState,
      SmallBodySelectorState smallBodySelectorState,
      CloseApproachBody closeApproachBody,
      Set<DataOutput> dataOutputSet,
      NetworkState networkState,
      CancelToken? cancelToken,
      bool disableInputs,
      SbdbCadBody? sbdbCadBody,
      Object? error});

  $DistanceRangeStateCopyWith<$Res> get distanceRangeState;
  $SmallBodyFilterStateCopyWith<$Res> get smallBodyFilterState;
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
    Object? distanceRangeState = null,
    Object? smallBodyFilterState = null,
    Object? smallBodySelectorState = null,
    Object? closeApproachBody = null,
    Object? dataOutputSet = null,
    Object? networkState = null,
    Object? cancelToken = freezed,
    Object? disableInputs = null,
    Object? sbdbCadBody = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      dateRange: freezed == dateRange
          ? _value.dateRange
          : dateRange // ignore: cast_nullable_to_non_nullable
              as DateTimeRange?,
      distanceRangeState: null == distanceRangeState
          ? _value.distanceRangeState
          : distanceRangeState // ignore: cast_nullable_to_non_nullable
              as DistanceRangeState,
      smallBodyFilterState: null == smallBodyFilterState
          ? _value.smallBodyFilterState
          : smallBodyFilterState // ignore: cast_nullable_to_non_nullable
              as SmallBodyFilterState,
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
      cancelToken: freezed == cancelToken
          ? _value.cancelToken
          : cancelToken // ignore: cast_nullable_to_non_nullable
              as CancelToken?,
      disableInputs: null == disableInputs
          ? _value.disableInputs
          : disableInputs // ignore: cast_nullable_to_non_nullable
              as bool,
      sbdbCadBody: freezed == sbdbCadBody
          ? _value.sbdbCadBody
          : sbdbCadBody // ignore: cast_nullable_to_non_nullable
              as SbdbCadBody?,
      error: freezed == error ? _value.error : error,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DistanceRangeStateCopyWith<$Res> get distanceRangeState {
    return $DistanceRangeStateCopyWith<$Res>(_value.distanceRangeState,
        (value) {
      return _then(_value.copyWith(distanceRangeState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SmallBodyFilterStateCopyWith<$Res> get smallBodyFilterState {
    return $SmallBodyFilterStateCopyWith<$Res>(_value.smallBodyFilterState,
        (value) {
      return _then(_value.copyWith(smallBodyFilterState: value) as $Val);
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
abstract class _$$CadStateImplCopyWith<$Res>
    implements $CadStateCopyWith<$Res> {
  factory _$$CadStateImplCopyWith(
          _$CadStateImpl value, $Res Function(_$CadStateImpl) then) =
      __$$CadStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTimeRange? dateRange,
      DistanceRangeState distanceRangeState,
      SmallBodyFilterState smallBodyFilterState,
      SmallBodySelectorState smallBodySelectorState,
      CloseApproachBody closeApproachBody,
      Set<DataOutput> dataOutputSet,
      NetworkState networkState,
      CancelToken? cancelToken,
      bool disableInputs,
      SbdbCadBody? sbdbCadBody,
      Object? error});

  @override
  $DistanceRangeStateCopyWith<$Res> get distanceRangeState;
  @override
  $SmallBodyFilterStateCopyWith<$Res> get smallBodyFilterState;
  @override
  $SmallBodySelectorStateCopyWith<$Res> get smallBodySelectorState;
  @override
  $SbdbCadBodyCopyWith<$Res>? get sbdbCadBody;
}

/// @nodoc
class __$$CadStateImplCopyWithImpl<$Res>
    extends _$CadStateCopyWithImpl<$Res, _$CadStateImpl>
    implements _$$CadStateImplCopyWith<$Res> {
  __$$CadStateImplCopyWithImpl(
      _$CadStateImpl _value, $Res Function(_$CadStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateRange = freezed,
    Object? distanceRangeState = null,
    Object? smallBodyFilterState = null,
    Object? smallBodySelectorState = null,
    Object? closeApproachBody = null,
    Object? dataOutputSet = null,
    Object? networkState = null,
    Object? cancelToken = freezed,
    Object? disableInputs = null,
    Object? sbdbCadBody = freezed,
    Object? error = freezed,
  }) {
    return _then(_$CadStateImpl(
      dateRange: freezed == dateRange
          ? _value.dateRange
          : dateRange // ignore: cast_nullable_to_non_nullable
              as DateTimeRange?,
      distanceRangeState: null == distanceRangeState
          ? _value.distanceRangeState
          : distanceRangeState // ignore: cast_nullable_to_non_nullable
              as DistanceRangeState,
      smallBodyFilterState: null == smallBodyFilterState
          ? _value.smallBodyFilterState
          : smallBodyFilterState // ignore: cast_nullable_to_non_nullable
              as SmallBodyFilterState,
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
      cancelToken: freezed == cancelToken
          ? _value.cancelToken
          : cancelToken // ignore: cast_nullable_to_non_nullable
              as CancelToken?,
      disableInputs: null == disableInputs
          ? _value.disableInputs
          : disableInputs // ignore: cast_nullable_to_non_nullable
              as bool,
      sbdbCadBody: freezed == sbdbCadBody
          ? _value.sbdbCadBody
          : sbdbCadBody // ignore: cast_nullable_to_non_nullable
              as SbdbCadBody?,
      error: freezed == error ? _value.error : error,
    ));
  }
}

/// @nodoc

class _$CadStateImpl implements _CadState {
  const _$CadStateImpl(
      {this.dateRange,
      this.distanceRangeState = const DistanceRangeState(),
      this.smallBodyFilterState = const SmallBodyFilterState(),
      this.smallBodySelectorState = const SmallBodySelectorState(),
      this.closeApproachBody = SbdbCadQueryParameters.closeApproachBodyDefault,
      final Set<DataOutput> dataOutputSet = const {},
      this.networkState = NetworkState.initial,
      this.cancelToken,
      this.disableInputs = false,
      this.sbdbCadBody,
      this.error})
      : _dataOutputSet = dataOutputSet;

  @override
  final DateTimeRange? dateRange;
  @override
  @JsonKey()
  final DistanceRangeState distanceRangeState;
  @override
  @JsonKey()
  final SmallBodyFilterState smallBodyFilterState;
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
  final CancelToken? cancelToken;
  @override
  @JsonKey()
  final bool disableInputs;
  @override
  final SbdbCadBody? sbdbCadBody;
  @override
  final Object? error;

  @override
  String toString() {
    return 'CadState(dateRange: $dateRange, distanceRangeState: $distanceRangeState, smallBodyFilterState: $smallBodyFilterState, smallBodySelectorState: $smallBodySelectorState, closeApproachBody: $closeApproachBody, dataOutputSet: $dataOutputSet, networkState: $networkState, cancelToken: $cancelToken, disableInputs: $disableInputs, sbdbCadBody: $sbdbCadBody, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CadStateImpl &&
            (identical(other.dateRange, dateRange) ||
                other.dateRange == dateRange) &&
            (identical(other.distanceRangeState, distanceRangeState) ||
                other.distanceRangeState == distanceRangeState) &&
            (identical(other.smallBodyFilterState, smallBodyFilterState) ||
                other.smallBodyFilterState == smallBodyFilterState) &&
            (identical(other.smallBodySelectorState, smallBodySelectorState) ||
                other.smallBodySelectorState == smallBodySelectorState) &&
            (identical(other.closeApproachBody, closeApproachBody) ||
                other.closeApproachBody == closeApproachBody) &&
            const DeepCollectionEquality()
                .equals(other._dataOutputSet, _dataOutputSet) &&
            (identical(other.networkState, networkState) ||
                other.networkState == networkState) &&
            (identical(other.cancelToken, cancelToken) ||
                other.cancelToken == cancelToken) &&
            (identical(other.disableInputs, disableInputs) ||
                other.disableInputs == disableInputs) &&
            (identical(other.sbdbCadBody, sbdbCadBody) ||
                other.sbdbCadBody == sbdbCadBody) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      dateRange,
      distanceRangeState,
      smallBodyFilterState,
      smallBodySelectorState,
      closeApproachBody,
      const DeepCollectionEquality().hash(_dataOutputSet),
      networkState,
      cancelToken,
      disableInputs,
      sbdbCadBody,
      const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CadStateImplCopyWith<_$CadStateImpl> get copyWith =>
      __$$CadStateImplCopyWithImpl<_$CadStateImpl>(this, _$identity);
}

abstract class _CadState implements CadState {
  const factory _CadState(
      {final DateTimeRange? dateRange,
      final DistanceRangeState distanceRangeState,
      final SmallBodyFilterState smallBodyFilterState,
      final SmallBodySelectorState smallBodySelectorState,
      final CloseApproachBody closeApproachBody,
      final Set<DataOutput> dataOutputSet,
      final NetworkState networkState,
      final CancelToken? cancelToken,
      final bool disableInputs,
      final SbdbCadBody? sbdbCadBody,
      final Object? error}) = _$CadStateImpl;

  @override
  DateTimeRange? get dateRange;
  @override
  DistanceRangeState get distanceRangeState;
  @override
  SmallBodyFilterState get smallBodyFilterState;
  @override
  SmallBodySelectorState get smallBodySelectorState;
  @override
  CloseApproachBody get closeApproachBody;
  @override
  Set<DataOutput> get dataOutputSet;
  @override
  NetworkState get networkState;
  @override
  CancelToken? get cancelToken;
  @override
  bool get disableInputs;
  @override
  SbdbCadBody? get sbdbCadBody;
  @override
  Object? get error;
  @override
  @JsonKey(ignore: true)
  _$$CadStateImplCopyWith<_$CadStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DistanceRangeState {
  List<double?> get valueList => throw _privateConstructorUsedError;
  List<String> get textList => throw _privateConstructorUsedError;
  List<DistanceUnit> get unitList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DistanceRangeStateCopyWith<DistanceRangeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DistanceRangeStateCopyWith<$Res> {
  factory $DistanceRangeStateCopyWith(
          DistanceRangeState value, $Res Function(DistanceRangeState) then) =
      _$DistanceRangeStateCopyWithImpl<$Res, DistanceRangeState>;
  @useResult
  $Res call(
      {List<double?> valueList,
      List<String> textList,
      List<DistanceUnit> unitList});
}

/// @nodoc
class _$DistanceRangeStateCopyWithImpl<$Res, $Val extends DistanceRangeState>
    implements $DistanceRangeStateCopyWith<$Res> {
  _$DistanceRangeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? valueList = null,
    Object? textList = null,
    Object? unitList = null,
  }) {
    return _then(_value.copyWith(
      valueList: null == valueList
          ? _value.valueList
          : valueList // ignore: cast_nullable_to_non_nullable
              as List<double?>,
      textList: null == textList
          ? _value.textList
          : textList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      unitList: null == unitList
          ? _value.unitList
          : unitList // ignore: cast_nullable_to_non_nullable
              as List<DistanceUnit>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DistanceRangeStateImplCopyWith<$Res>
    implements $DistanceRangeStateCopyWith<$Res> {
  factory _$$DistanceRangeStateImplCopyWith(_$DistanceRangeStateImpl value,
          $Res Function(_$DistanceRangeStateImpl) then) =
      __$$DistanceRangeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<double?> valueList,
      List<String> textList,
      List<DistanceUnit> unitList});
}

/// @nodoc
class __$$DistanceRangeStateImplCopyWithImpl<$Res>
    extends _$DistanceRangeStateCopyWithImpl<$Res, _$DistanceRangeStateImpl>
    implements _$$DistanceRangeStateImplCopyWith<$Res> {
  __$$DistanceRangeStateImplCopyWithImpl(_$DistanceRangeStateImpl _value,
      $Res Function(_$DistanceRangeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? valueList = null,
    Object? textList = null,
    Object? unitList = null,
  }) {
    return _then(_$DistanceRangeStateImpl(
      valueList: null == valueList
          ? _value._valueList
          : valueList // ignore: cast_nullable_to_non_nullable
              as List<double?>,
      textList: null == textList
          ? _value._textList
          : textList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      unitList: null == unitList
          ? _value._unitList
          : unitList // ignore: cast_nullable_to_non_nullable
              as List<DistanceUnit>,
    ));
  }
}

/// @nodoc

class _$DistanceRangeStateImpl implements _DistanceRangeState {
  const _$DistanceRangeStateImpl(
      {final List<double?> valueList = const [],
      final List<String> textList = const [],
      final List<DistanceUnit> unitList = const []})
      : _valueList = valueList,
        _textList = textList,
        _unitList = unitList;

  final List<double?> _valueList;
  @override
  @JsonKey()
  List<double?> get valueList {
    if (_valueList is EqualUnmodifiableListView) return _valueList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_valueList);
  }

  final List<String> _textList;
  @override
  @JsonKey()
  List<String> get textList {
    if (_textList is EqualUnmodifiableListView) return _textList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_textList);
  }

  final List<DistanceUnit> _unitList;
  @override
  @JsonKey()
  List<DistanceUnit> get unitList {
    if (_unitList is EqualUnmodifiableListView) return _unitList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unitList);
  }

  @override
  String toString() {
    return 'DistanceRangeState(valueList: $valueList, textList: $textList, unitList: $unitList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DistanceRangeStateImpl &&
            const DeepCollectionEquality()
                .equals(other._valueList, _valueList) &&
            const DeepCollectionEquality().equals(other._textList, _textList) &&
            const DeepCollectionEquality().equals(other._unitList, _unitList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_valueList),
      const DeepCollectionEquality().hash(_textList),
      const DeepCollectionEquality().hash(_unitList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DistanceRangeStateImplCopyWith<_$DistanceRangeStateImpl> get copyWith =>
      __$$DistanceRangeStateImplCopyWithImpl<_$DistanceRangeStateImpl>(
          this, _$identity);
}

abstract class _DistanceRangeState implements DistanceRangeState {
  const factory _DistanceRangeState(
      {final List<double?> valueList,
      final List<String> textList,
      final List<DistanceUnit> unitList}) = _$DistanceRangeStateImpl;

  @override
  List<double?> get valueList;
  @override
  List<String> get textList;
  @override
  List<DistanceUnit> get unitList;
  @override
  @JsonKey(ignore: true)
  _$$DistanceRangeStateImplCopyWith<_$DistanceRangeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SmallBodyFilterState {
  bool get enabled => throw _privateConstructorUsedError;
  SmallBodyFilter get smallBodyFilter => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SmallBodyFilterStateCopyWith<SmallBodyFilterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmallBodyFilterStateCopyWith<$Res> {
  factory $SmallBodyFilterStateCopyWith(SmallBodyFilterState value,
          $Res Function(SmallBodyFilterState) then) =
      _$SmallBodyFilterStateCopyWithImpl<$Res, SmallBodyFilterState>;
  @useResult
  $Res call({bool enabled, SmallBodyFilter smallBodyFilter});
}

/// @nodoc
class _$SmallBodyFilterStateCopyWithImpl<$Res,
        $Val extends SmallBodyFilterState>
    implements $SmallBodyFilterStateCopyWith<$Res> {
  _$SmallBodyFilterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? smallBodyFilter = null,
  }) {
    return _then(_value.copyWith(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      smallBodyFilter: null == smallBodyFilter
          ? _value.smallBodyFilter
          : smallBodyFilter // ignore: cast_nullable_to_non_nullable
              as SmallBodyFilter,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SmallBodyFilterStateImplCopyWith<$Res>
    implements $SmallBodyFilterStateCopyWith<$Res> {
  factory _$$SmallBodyFilterStateImplCopyWith(_$SmallBodyFilterStateImpl value,
          $Res Function(_$SmallBodyFilterStateImpl) then) =
      __$$SmallBodyFilterStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool enabled, SmallBodyFilter smallBodyFilter});
}

/// @nodoc
class __$$SmallBodyFilterStateImplCopyWithImpl<$Res>
    extends _$SmallBodyFilterStateCopyWithImpl<$Res, _$SmallBodyFilterStateImpl>
    implements _$$SmallBodyFilterStateImplCopyWith<$Res> {
  __$$SmallBodyFilterStateImplCopyWithImpl(_$SmallBodyFilterStateImpl _value,
      $Res Function(_$SmallBodyFilterStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? smallBodyFilter = null,
  }) {
    return _then(_$SmallBodyFilterStateImpl(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      smallBodyFilter: null == smallBodyFilter
          ? _value.smallBodyFilter
          : smallBodyFilter // ignore: cast_nullable_to_non_nullable
              as SmallBodyFilter,
    ));
  }
}

/// @nodoc

class _$SmallBodyFilterStateImpl implements _SmallBodyFilterState {
  const _$SmallBodyFilterStateImpl(
      {this.enabled = true,
      this.smallBodyFilter = SbdbCadQueryParameters.smallBodyFilterDefault});

  @override
  @JsonKey()
  final bool enabled;
  @override
  @JsonKey()
  final SmallBodyFilter smallBodyFilter;

  @override
  String toString() {
    return 'SmallBodyFilterState(enabled: $enabled, smallBodyFilter: $smallBodyFilter)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmallBodyFilterStateImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.smallBodyFilter, smallBodyFilter) ||
                other.smallBodyFilter == smallBodyFilter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, enabled, smallBodyFilter);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SmallBodyFilterStateImplCopyWith<_$SmallBodyFilterStateImpl>
      get copyWith =>
          __$$SmallBodyFilterStateImplCopyWithImpl<_$SmallBodyFilterStateImpl>(
              this, _$identity);
}

abstract class _SmallBodyFilterState implements SmallBodyFilterState {
  const factory _SmallBodyFilterState(
      {final bool enabled,
      final SmallBodyFilter smallBodyFilter}) = _$SmallBodyFilterStateImpl;

  @override
  bool get enabled;
  @override
  SmallBodyFilter get smallBodyFilter;
  @override
  @JsonKey(ignore: true)
  _$$SmallBodyFilterStateImplCopyWith<_$SmallBodyFilterStateImpl>
      get copyWith => throw _privateConstructorUsedError;
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
abstract class _$$SmallBodySelectorStateImplCopyWith<$Res>
    implements $SmallBodySelectorStateCopyWith<$Res> {
  factory _$$SmallBodySelectorStateImplCopyWith(
          _$SmallBodySelectorStateImpl value,
          $Res Function(_$SmallBodySelectorStateImpl) then) =
      __$$SmallBodySelectorStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SmallBodySelector? smallBodySelector, int? spkId, String? designation});
}

/// @nodoc
class __$$SmallBodySelectorStateImplCopyWithImpl<$Res>
    extends _$SmallBodySelectorStateCopyWithImpl<$Res,
        _$SmallBodySelectorStateImpl>
    implements _$$SmallBodySelectorStateImplCopyWith<$Res> {
  __$$SmallBodySelectorStateImplCopyWithImpl(
      _$SmallBodySelectorStateImpl _value,
      $Res Function(_$SmallBodySelectorStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? smallBodySelector = freezed,
    Object? spkId = freezed,
    Object? designation = freezed,
  }) {
    return _then(_$SmallBodySelectorStateImpl(
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

class _$SmallBodySelectorStateImpl implements _SmallBodySelectorState {
  const _$SmallBodySelectorStateImpl(
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
            other is _$SmallBodySelectorStateImpl &&
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
  _$$SmallBodySelectorStateImplCopyWith<_$SmallBodySelectorStateImpl>
      get copyWith => __$$SmallBodySelectorStateImplCopyWithImpl<
          _$SmallBodySelectorStateImpl>(this, _$identity);
}

abstract class _SmallBodySelectorState implements SmallBodySelectorState {
  const factory _SmallBodySelectorState(
      {final SmallBodySelector? smallBodySelector,
      final int? spkId,
      final String? designation}) = _$SmallBodySelectorStateImpl;

  @override
  SmallBodySelector? get smallBodySelector;
  @override
  int? get spkId;
  @override
  String? get designation;
  @override
  @JsonKey(ignore: true)
  _$$SmallBodySelectorStateImplCopyWith<_$SmallBodySelectorStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
