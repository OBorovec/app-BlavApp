part of 'places_catering_bloc.dart';

abstract class PlacesCateringEvent extends Equatable {
  const PlacesCateringEvent();

  @override
  List<Object> get props => [];
}

class UpdateCaterData extends PlacesCateringEvent {
  final CateringState cateringState;

  const UpdateCaterData({
    required this.cateringState,
  });
}
