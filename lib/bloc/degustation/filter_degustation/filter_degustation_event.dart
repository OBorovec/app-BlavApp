part of 'filter_degustation_bloc.dart';

abstract class FilterDegustationEvent extends Equatable {
  const FilterDegustationEvent();

  @override
  List<Object> get props => [];
}

class UpdateDegusItems extends FilterDegustationEvent {
  final List<DegusItem> degusItems;

  const UpdateDegusItems({
    required this.degusItems,
  });
}

class ToggleSearch extends FilterDegustationEvent {
  const ToggleSearch();
}

class SetAvailableFilters extends FilterDegustationEvent {
  const SetAvailableFilters();
}

class ApplyDegusFilters extends FilterDegustationEvent {
  const ApplyDegusFilters();
}

class ResetDegusFilters extends FilterDegustationEvent {
  const ResetDegusFilters();
}

class DegusAlcoholTypeFilter extends FilterDegustationEvent {
  final DegusAlcoholType type;
  const DegusAlcoholTypeFilter({
    required this.type,
  });
}

class DegusOriginFilter extends FilterDegustationEvent {
  final String origin;
  const DegusOriginFilter({
    required this.origin,
  });
}

class DegusPlaceFilter extends FilterDegustationEvent {
  final String place;
  const DegusPlaceFilter({
    required this.place,
  });
}

class DegusRatingFilter extends FilterDegustationEvent {
  final double score;
  const DegusRatingFilter({
    required this.score,
  });
}

class DegusAlcoholFilter extends FilterDegustationEvent {
  final double min;
  final double max;
  const DegusAlcoholFilter({
    required this.min,
    required this.max,
  });
}

class DegusTextFilter extends FilterDegustationEvent {
  final String text;

  const DegusTextFilter(this.text);
}
