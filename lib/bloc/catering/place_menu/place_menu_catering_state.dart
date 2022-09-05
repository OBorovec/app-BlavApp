part of 'place_menu_catering_bloc.dart';

class MenuSec extends Equatable {
  final MealItemType type;
  final List<MealItem> items;

  const MenuSec({
    required this.type,
    required this.items,
  });

  @override
  List<Object> get props => [type, items];
}

class PlaceMenuCateringState extends Equatable {
  final List<MenuSec> sections;
  const PlaceMenuCateringState({
    this.sections = const [],
  });

  @override
  List<Object> get props => [sections];
}
