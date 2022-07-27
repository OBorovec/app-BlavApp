part of 'places_catering_bloc.dart';

class CateringPlaceInfo extends Equatable {
  final CaterPlace place;
  final List<CateringPlaceMenuSec> items;

  const CateringPlaceInfo({
    required this.place,
    required this.items,
  });

  @override
  List<Object?> get props => [place, items];
}

class CateringPlaceMenuSec extends Equatable {
  final CaterItemType type;
  final List<CaterItem> items;

  const CateringPlaceMenuSec({
    required this.type,
    required this.items,
  });

  @override
  List<Object> get props => [type, items];
}

class PlacesCateringState extends Equatable {
  final List<CateringPlaceInfo> places;

  const PlacesCateringState({
    required this.places,
  });

  @override
  List<Object> get props => [places];

  PlacesCateringState copyWith({
    List<CateringPlaceInfo>? places,
  }) {
    return PlacesCateringState(
      places: places ?? this.places,
    );
  }
}
