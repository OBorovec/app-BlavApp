part of 'highlight_degustation_bloc.dart';

abstract class HighlightDegustationEvent extends Equatable {
  const HighlightDegustationEvent();

  @override
  List<Object> get props => [];
}

class UpdateDegustation extends HighlightDegustationEvent {
  final Map<String, String>? desc;
  final List<DegusItem> degustationItems;
  final Map<String, DegusPlace> degustationPlaces;

  const UpdateDegustation({
    this.desc,
    required this.degustationItems,
    required this.degustationPlaces,
  });
}

class UpdateUserData extends HighlightDegustationEvent {
  final Map<String, double?> myRatings;
  final Set<String> myFavorite;

  const UpdateUserData({
    required this.myFavorite,
    required this.myRatings,
  });
}

class UpdateViewData extends HighlightDegustationEvent {
  const UpdateViewData();
}
