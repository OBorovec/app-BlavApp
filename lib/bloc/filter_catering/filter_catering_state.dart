part of 'filter_catering_bloc.dart';

class FilterCateringState extends Equatable {
  final List<CaterItem> cateringItems;
  final List<CaterItem> cateringItemsFiltered;
  // Programme filter options
  final Set<CaterItemType> availableItemTypes;
  final Set<String?> availablePlaces;
  // Filters
  final Set<CaterItemType> itemTypeFilter;
  final Set<String> placesFilter;
  final Set<int> allergensFilter;
  final bool onlyVegetarian;
  final bool onlyVegan;
  final bool onlyGlutenFree;
  final String queryString;

  const FilterCateringState({
    this.cateringItems = const <CaterItem>[],
    this.cateringItemsFiltered = const <CaterItem>[],
    this.availableItemTypes = const <CaterItemType>{},
    this.availablePlaces = const <String>{},
    this.itemTypeFilter = const <CaterItemType>{},
    this.placesFilter = const <String>{},
    this.allergensFilter = const <int>{},
    this.onlyVegetarian = false,
    this.onlyVegan = false,
    this.onlyGlutenFree = false,
    this.queryString = '',
  });

  @override
  List<Object> get props => [
        cateringItems,
        cateringItemsFiltered,
        itemTypeFilter,
        placesFilter,
        allergensFilter,
        onlyVegetarian,
        onlyVegan,
        onlyGlutenFree,
        queryString,
      ];

  FilterCateringState copyWith({
    List<CaterItem>? cateringItems,
    List<CaterItem>? cateringItemsFiltered,
    Set<CaterItemType>? availableItemTypes,
    Set<String?>? availablePlaces,
    Set<CaterItemType>? itemTypeFilter,
    Set<String>? placesFilter,
    Set<int>? allergensFilter,
    bool? onlyVegetarian,
    bool? onlyVegan,
    bool? onlyGlutenFree,
    String? queryString,
  }) {
    return FilterCateringState(
      cateringItems: cateringItems ?? this.cateringItems,
      cateringItemsFiltered:
          cateringItemsFiltered ?? this.cateringItemsFiltered,
      availableItemTypes: availableItemTypes ?? this.availableItemTypes,
      availablePlaces: availablePlaces ?? this.availablePlaces,
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
