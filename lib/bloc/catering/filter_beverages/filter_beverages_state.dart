part of 'filter_beverages_bloc.dart';

class FilterBeveragesState extends Equatable {
  final List<BeverageItem> items;
  final List<BeverageItem> itemsFiltered;
  // Control
  final bool searchActive;
  // Programme filter options
  final Set<BeverageItemType> availableItemTypes;
  final Set<String> availablePlaces;
  // Filters
  final Set<BeverageItemType> itemTypeFilter;
  final Set<String> placesFilter;
  final bool onlyHot;
  final bool onlyAlcoholic;
  final bool onlyNonAlcoholic;
  final String queryString;

  const FilterBeveragesState({
    this.items = const [],
    this.itemsFiltered = const [],
    this.searchActive = false,
    this.availableItemTypes = const {},
    this.availablePlaces = const {},
    this.itemTypeFilter = const {},
    this.placesFilter = const {},
    this.onlyHot = false,
    this.onlyAlcoholic = false,
    this.onlyNonAlcoholic = false,
    this.queryString = '',
  });

  @override
  List<Object> get props => [
        items,
        searchActive,
        itemsFiltered,
        itemTypeFilter,
        placesFilter,
        onlyHot,
        onlyAlcoholic,
        onlyNonAlcoholic,
        queryString,
      ];

  FilterBeveragesState copyWith({
    List<BeverageItem>? items,
    List<BeverageItem>? itemsFiltered,
    bool? searchActive,
    Set<BeverageItemType>? availableItemTypes,
    Set<String>? availablePlaces,
    Set<BeverageItemType>? itemTypeFilter,
    Set<String>? placesFilter,
    bool? onlyHot,
    bool? onlyAlcoholic,
    bool? onlyNonAlcoholic,
    String? queryString,
  }) {
    return FilterBeveragesState(
      items: items ?? this.items,
      itemsFiltered: itemsFiltered ?? this.itemsFiltered,
      searchActive: searchActive ?? this.searchActive,
      availableItemTypes: availableItemTypes ?? this.availableItemTypes,
      availablePlaces: availablePlaces ?? this.availablePlaces,
      itemTypeFilter: itemTypeFilter ?? this.itemTypeFilter,
      placesFilter: placesFilter ?? this.placesFilter,
      onlyHot: onlyHot ?? this.onlyHot,
      onlyAlcoholic: onlyAlcoholic ?? this.onlyAlcoholic,
      onlyNonAlcoholic: onlyNonAlcoholic ?? this.onlyNonAlcoholic,
      queryString: queryString ?? this.queryString,
    );
  }

  @override
  String toString() {
    return 'FilterBeveragesState(items: $items, filtered: $itemsFiltered, searchActive: $searchActive, availableItemTypes: $availableItemTypes, availablePlaces: $availablePlaces, placesFilter: $placesFilter, onlyHot: $onlyHot, onlyAlcoholic: $onlyAlcoholic, onlyNonAlcoholic: $onlyNonAlcoholic, queryString: $queryString)';
  }
}
