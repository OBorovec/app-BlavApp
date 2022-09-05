part of 'filter_meals_bloc.dart';

abstract class FilterMealEvent extends Equatable {
  const FilterMealEvent();

  @override
  List<Object> get props => [];
}

class UpdateMealItems extends FilterMealEvent {
  final List<MealItem> items;

  const UpdateMealItems({
    required this.items,
  });
}

class ToggleMealSearch extends FilterMealEvent {
  const ToggleMealSearch();
}

class SetMealAvailableFilters extends FilterMealEvent {
  const SetMealAvailableFilters();
}

class ApplyMealFilters extends FilterMealEvent {
  const ApplyMealFilters();
}

class ResetMealFilters extends FilterMealEvent {
  const ResetMealFilters();
}

class CateringTypeFilter extends FilterMealEvent {
  final CaterItemType type;

  const CateringTypeFilter(this.type);
}

class MealPlaceFilter extends FilterMealEvent {
  final String place;

  const MealPlaceFilter(this.place);
}

class MealAllergenFilter extends FilterMealEvent {
  final int allergen;

  const MealAllergenFilter(this.allergen);
}

class MealVegetarianFilter extends FilterMealEvent {
  final bool value;

  const MealVegetarianFilter(this.value);
}

class MealVeganFilter extends FilterMealEvent {
  final bool value;

  const MealVeganFilter(this.value);
}

class MealGlutenFreeFilter extends FilterMealEvent {
  final bool value;

  const MealGlutenFreeFilter(this.value);
}

class MealTextFilter extends FilterMealEvent {
  final String text;

  const MealTextFilter(this.text);
}
