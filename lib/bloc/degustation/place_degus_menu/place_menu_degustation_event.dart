part of 'place_menu_degustation_bloc.dart';

abstract class PlaceMenuDegustationEvent extends Equatable {
  const PlaceMenuDegustationEvent();

  @override
  List<Object> get props => [];
}

class UpdateMenu extends PlaceMenuDegustationEvent {
  const UpdateMenu();
}
