part of 'place_menu_degustation_bloc.dart';

class MenuSec extends Equatable {
  final DegusAlcoholType type;
  final List<DegusItem> items;

  const MenuSec({
    required this.type,
    required this.items,
  });

  @override
  List<Object> get props => [type, items];
}

class PlaceMenuDegustationState extends Equatable {
  final List<MenuSec> sections;

  const PlaceMenuDegustationState({
    this.sections = const [],
  });

  @override
  List<Object> get props => [sections];
}
