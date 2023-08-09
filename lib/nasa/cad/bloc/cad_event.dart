part of 'cad_bloc.dart';

@immutable
sealed class CadEvent {
  const CadEvent();
}

class CadRequested extends CadEvent {
  const CadRequested({this.queryParameters});

  final JsonMap? queryParameters;
}

class CadDateRangeSelected extends CadEvent {
  const CadDateRangeSelected({this.dateRange});

  final DateTimeRange? dateRange;
}

class CadDistanceRangeEvent extends CadEvent {
  const CadDistanceRangeEvent({required this.distanceRange});

  final DistanceRange distanceRange;
}

class CadSmallBodySelected extends CadEvent {
  const CadSmallBodySelected({this.smallBody});

  final SmallBody? smallBody;
}

class CadSmallBodySelectorEvent extends CadEvent {
  const CadSmallBodySelectorEvent({
    this.smallBodySelector,
    this.spkId,
    this.designation,
  });

  final SmallBodySelector? smallBodySelector;
  final int? spkId;
  final String? designation;
}

class CadCloseApproachBodySelected extends CadEvent {
  const CadCloseApproachBodySelected({this.closeApproachBody});

  final CloseApproachBody? closeApproachBody;
}

class CadDataOutputEvent extends CadEvent {
  const CadDataOutputEvent({required this.dataOutputSet});

  final Set<DataOutput> dataOutputSet;
}
