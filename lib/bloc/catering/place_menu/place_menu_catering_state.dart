part of 'place_menu_catering_bloc.dart';

class PlaceMenuCateringState extends Equatable {
  final bool hasMeals;
  final List<MenuMealSec> mealSections;
  final bool hasBeverages;
  final List<MenuBeverageSec> beverageSections;
  const PlaceMenuCateringState({
    this.hasMeals = false,
    this.mealSections = const [],
    this.hasBeverages = false,
    this.beverageSections = const [],
  });

  @override
  List<Object> get props => [
        hasMeals,
        mealSections,
        hasBeverages,
        beverageSections,
      ];
}

class MenuMealSec extends Equatable {
  final MealItemType type;
  final List<MealItem> items;

  const MenuMealSec({
    required this.type,
    required this.items,
  });

  @override
  List<Object> get props => [type, items];
}

class MenuBeverageSec extends Equatable {
  final BeverageItemType type;
  final List<BeverageItem> items;

  const MenuBeverageSec({
    required this.type,
    required this.items,
  });

  @override
  List<Object> get props => [type, items];
}
