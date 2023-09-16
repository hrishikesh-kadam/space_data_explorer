part of 'cad_bloc.dart';

@immutable
sealed class CadEvent {
  const CadEvent();
}

class CadRequested extends CadEvent {
  const CadRequested({this.queryParameters});

  final JsonMap? queryParameters;
}

class CadResultOpened extends CadEvent {
  const CadResultOpened();
}

class CadDateRangeSelected extends CadEvent {
  const CadDateRangeSelected({this.dateRange});

  final DateTimeRange? dateRange;
}

class CadDistanceEvent extends CadEvent {
  const CadDistanceEvent({
    required this.valueList,
    required this.textList,
    required this.unitList,
  })  : assert(valueList.length == 2),
        assert(textList.length == 2);
  // assert(unitList.length == 2);

  final List<double?> valueList;
  final List<String> textList;
  final List<DistanceUnit> unitList;
}

class CadSmallBodyFilterSelected extends CadEvent {
  const CadSmallBodyFilterSelected({this.smallBodyFilter});

  final SmallBodyFilter? smallBodyFilter;
}

class CadSmallBodySelectorEvent extends CadEvent {
  const CadSmallBodySelectorEvent({
    required this.smallBodySelectorState,
  });

  final SmallBodySelectorState smallBodySelectorState;
}

class CadCloseApproachBodySelected extends CadEvent {
  const CadCloseApproachBodySelected({this.closeApproachBody});

  final CloseApproachBody? closeApproachBody;
}

class CadDataOutputEvent extends CadEvent {
  const CadDataOutputEvent({required this.dataOutputSet});

  final Set<DataOutput> dataOutputSet;
}
