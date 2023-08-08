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

class CadTotalOnlySelected extends CadEvent {
  const CadTotalOnlySelected(this.selected);

  final bool? selected;
}

class CadDiameterSelected extends CadEvent {
  const CadDiameterSelected(this.selected);

  final bool? selected;
}

class CadFullnameSelected extends CadEvent {
  const CadFullnameSelected(this.selected);

  final bool? selected;
}
