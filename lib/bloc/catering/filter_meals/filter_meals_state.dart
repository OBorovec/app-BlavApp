part of 'filter_meals_bloc.dart';

class FilterMealsState extends Equatable {
  final List<MealItem> items;
  final List<MealItem> itemsFiltered;
  // Control
  final bool searchActive;
  // Programme filter options
  final Set<MealItemType> availableItemTypes;
  final Set<String> availablePlaces;
  final Set<int> availableAllergens;
  // Filters
  final Set<MealItemType> itemTypeFilter;
  final Set<String> placesFilter;
  final Set<int> allergensFilter;
  final bool onlyVegetarian;
  final bool onlyVegan;
  final bool onlyGlutenFree;
  final String queryString;

  const FilterMealsState({
    this.items = const <MealItem>[],
    this.itemsFiltered = const <MealItem>[],
    this.searchActive = false,
    this.availableItemTypes = const <MealItemType>{},
    this.availablePlaces = const <String>{},
    this.availableAllergens = const <int>{1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
    this.itemTypeFilter = const <MealItemType>{},
    this.placesFilter = const <String>{},
    this.allergensFilter = const <int>{},
    this.onlyVegetarian = false,
    this.onlyVegan = false,
    this.onlyGlutenFree = false,
    this.queryString = '',
  });

  @override
  List<Object> get props => [
        items,
        searchActive,
        itemsFiltered,
        itemTypeFilter,
        placesFilter,
        allergensFilter,
        onlyVegetarian,
        onlyVegan,
        onlyGlutenFree,
        queryString,
      ];

  FilterMealsState copyWith({
    List<MealItem>? cateringItems,
    List<MealItem>? cateringItemsFiltered,
    bool? searchActive,
    Set<MealItemType>? availableItemTypes,
    Set<String>? availablePlaces,
    Set<int>? availableAllergens,
    Set<MealItemType>? itemTypeFilter,
    Set<String>? placesFilter,
    Set<int>? allergensFilter,
    bool? onlyVegetarian,
    bool? onlyVegan,
    bool? onlyGlutenFree,
    String? queryString,
  }) {
    return FilterMealsState(
      items: cateringItems ?? this.items,
      itemsFiltered: cateringItemsFiltered ?? this.itemsFiltered,
      searchActive: searchActive ?? this.searchActive,
      availableItemTypes: availableItemTypes ?? this.availableItemTypes,
      availablePlaces: availablePlaces ?? this.availablePlaces,
      availableAllergens: availableAllergens ?? this.availableAllergens,
      itemTypeFilter: itemTypeFilter ?? this.itemTypeFilter,
      placesFilter: placesFilter ?? this.placesFilter,
      allergensFilter: allergensFilter ?? this.allergensFilter,
      onlyVegetarian: onlyVegetarian ?? this.onlyVegetarian,
      onlyVegan: onlyVegan ?? this.onlyVegan,
      onlyGlutenFree: onlyGlutenFree ?? this.onlyGlutenFree,
      queryString: queryString ?? this.queryString,
    );
  }
}
