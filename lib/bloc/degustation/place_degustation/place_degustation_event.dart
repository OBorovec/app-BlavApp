part of 'place_degustation_bloc.dart';

abstract class PlaceDegustationEvent extends Equatable {
  const PlaceDegustationEvent();

  @override
  List<Object> get props => [];
}

class UpdateDegusData extends PlaceDegustationEvent {
  final DegustationState degustationState;

  const UpdateDegusData({
    required this.degustationState,
  });
}
