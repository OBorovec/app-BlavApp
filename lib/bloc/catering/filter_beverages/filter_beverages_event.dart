part of 'filter_beverages_bloc.dart';

abstract class FilterBeverageEvent extends Equatable {
  const FilterBeverageEvent();

  @override
  List<Object> get props => [];
}

class UpdateBeverageItems extends FilterBeverageEvent {
  final List<BeverageItem> items;

  const UpdateBeverageItems({
    required this.items,
  });
}

class ToggleBeverageSearch extends FilterBeverageEvent {
  const ToggleBeverageSearch();
}

class SetBeverageAvailableFilters extends FilterBeverageEvent {
  const SetBeverageAvailableFilters();
}

class ApplyBeverageFilters extends FilterBeverageEvent {
  const ApplyBeverageFilters();
}

class ResetBeverageFilters extends FilterBeverageEvent {
  const ResetBeverageFilters();
}

class BeverageTypeFilter extends FilterBeverageEvent {
  final BeverageItemType type;

  const BeverageTypeFilter(this.type);
}

class BeveragePlaceFilter extends FilterBeverageEvent {
  final String place;

  const BeveragePlaceFilter(this.place);
}

class BeverageHotFilter extends FilterBeverageEvent {
  final bool value;

  const BeverageHotFilter(this.value);
}

class BeverageAlcoholicFilter extends FilterBeverageEvent {
  final bool value;

  const BeverageAlcoholicFilter(this.value);
}

class BeverageNonAlcoholicFilter extends FilterBeverageEvent {
  final bool value;

  const BeverageNonAlcoholicFilter(this.value);
}

class BeverageTextFilter extends FilterBeverageEvent {
  final String text;

  const BeverageTextFilter(this.text);
}
