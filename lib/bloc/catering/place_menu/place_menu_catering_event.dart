part of 'place_menu_catering_bloc.dart';

abstract class PlaceMenuCateringEvent extends Equatable {
  const PlaceMenuCateringEvent();

  @override
  List<Object> get props => [];
}

class UpdateMenu extends PlaceMenuCateringEvent {
  const UpdateMenu();
}
