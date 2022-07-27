part of 'place_degustation_bloc.dart';

class DegustationPlaceInfo extends Equatable {
  final DegusPlace place;
  final List<DegustationPlaceMenuSec> items;

  const DegustationPlaceInfo({
    required this.place,
    required this.items,
  });

  @override
  List<Object?> get props => [place, items];
}

class DegustationPlaceMenuSec extends Equatable {
  final DegusAlcoholType type;
  final List<DegusItem> items;

  const DegustationPlaceMenuSec({
    required this.type,
    required this.items,
  });

  @override
  List<Object> get props => [type, items];
}

class PlaceDegustationState extends Equatable {
  final List<DegustationPlaceInfo> places;

  const PlaceDegustationState({
    required this.places,
  });

  @override
  List<Object> get props => [places];

  PlaceDegustationState copyWith({
    List<DegustationPlaceInfo>? places,
  }) {
    return PlaceDegustationState(
      places: places ?? this.places,
    );
  }
}
