import 'dart:async';

import 'package:blavapp/model/catering.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'place_menu_catering_event.dart';
part 'place_menu_catering_state.dart';

const List<MealItemType> menuOrder = [
  MealItemType.starter,
  MealItemType.soup,
  MealItemType.main,
  MealItemType.side,
  MealItemType.other,
  MealItemType.desert,
  MealItemType.snack,
];

const List<BeverageItemType> beverageOrder = [
  BeverageItemType.soft,
  BeverageItemType.beer,
  BeverageItemType.wine,
  BeverageItemType.spirit,
  BeverageItemType.mix,
  BeverageItemType.tea,
  BeverageItemType.coffee,
  BeverageItemType.other,
];

class PlaceMenuCateringBloc
    extends Bloc<PlaceMenuCateringEvent, PlaceMenuCateringState> {
  final Catering catering;
  final String placeRef;
  PlaceMenuCateringBloc({
    required this.catering,
    required this.placeRef,
  }) : super(const PlaceMenuCateringState()) {
    on<UpdateMenu>(_updateMenu);
    add(const UpdateMenu());
  }

  FutureOr<void> _updateMenu(
    UpdateMenu event,
    Emitter<PlaceMenuCateringState> emit,
  ) {
    final List<MealItem> placeMealItems = catering.meals.values
        .where((item) => item.placeRef.contains(placeRef))
        .toList();
    final List<BeverageItem> placeBeverageItems = catering.beverages.values
        .where((item) => item.placeRef.contains(placeRef))
        .toList();
    emit(PlaceMenuCateringState(
      hasMeals: placeMealItems.isNotEmpty,
      mealSections: menuOrder.map(
        (type) {
          final List<MealItem> items =
              placeMealItems.where((item) => item.type == type).toList();
          items.sort((a, b) => a.id.compareTo(b.id));
          return MenuMealSec(
            type: type,
            items: items,
          );
        },
      ).toList(),
      hasBeverages: placeBeverageItems.isNotEmpty,
      beverageSections: beverageOrder.map(
        (type) {
          final List<BeverageItem> items =
              placeBeverageItems.where((item) => item.type == type).toList();
          items.sort((a, b) => a.id.compareTo(b.id));
          return MenuBeverageSec(
            type: type,
            items: items,
          );
        },
      ).toList(),
    ));
  }
}
