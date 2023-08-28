part of 'highlight_degustation_bloc.dart';

abstract class HighlightDegustationEvent extends Equatable {
  const HighlightDegustationEvent();

  @override
  List<Object> get props => [];
}

class UpdateDegustation extends HighlightDegustationEvent {
  final Map<String, String>? headerText;
  final List<DegusItem> degustationItems;
  final Map<String, DegusPlace> degustationPlaces;

  const UpdateDegustation({
    this.headerText,
    required this.degustationItems,
    required this.degustationPlaces,
  });
}

class UpdateUserData extends HighlightDegustationEvent {
  final Map<String, double?> userRatings;
  final Set<String> userFavorite;

  const UpdateUserData({
    required this.userFavorite,
    required this.userRatings,
  });
}

class UpdateLocalUserData extends HighlightDegustationEvent {
  final Set<String> userTasted;

  const UpdateLocalUserData({
    required this.userTasted,
  });
}

class CalculateViewData extends HighlightDegustationEvent {
  const CalculateViewData();
}
