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

class CadDistRangeEvent extends CadEvent {
  const CadDistRangeEvent({
    required this.distRange,
    required this.distRangeText,
  });

  final DistanceRange distRange;
  final ValueRange<String, Never> distRangeText;
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
