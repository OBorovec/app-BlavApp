part of 'filter_degustation_bloc.dart';

class FilterDegustationState extends Equatable {
  final List<DegusItem> degusItems;
  final List<DegusItem> degusItemsFiltered;
  // Control
  final bool searchActive;
  // Programme filter options
  final Set<DegusAlcoholType> availableAlcoholTypes;
  final Set<String> availableOrigins;
  final Set<String> availablePlaces;
  // Filters
  final Set<DegusAlcoholType> alcoholTypeFilter;
  final Set<String> originFilter;
  final Set<String> placeFilter;
  final double minRating;
  final double minAlcohol;
  final double maxAlcohol;
  final String queryString;

  const FilterDegustationState({
    this.degusItems = const <DegusItem>[],
    this.degusItemsFiltered = const <DegusItem>[],
    this.searchActive = false,
    this.availableAlcoholTypes = const {},
    this.availableOrigins = const {},
    this.availablePlaces = const {},
    this.alcoholTypeFilter = const {},
    this.originFilter = const {},
    this.placeFilter = const {},
    this.minRating = 0,
    this.minAlcohol = 0,
    this.maxAlcohol = 100,
    this.queryString = '',
  });

  @override
  List<Object> get props => [
        degusItems,
        degusItemsFiltered,
        searchActive,
        availableAlcoholTypes,
        availableOrigins,
        availablePlaces,
        alcoholTypeFilter,
        originFilter,
        placeFilter,
        minRating,
        minAlcohol,
        maxAlcohol,
        queryString,
      ];

  FilterDegustationState copyWith({
    List<DegusItem>? degusItems,
    List<DegusItem>? degusItemsFiltered,
    bool? searchActive,
    Set<DegusAlcoholType>? availableAlcoholTypes,
    Set<String>? availableOrigins,
    Set<String>? availablePlaces,
    Set<DegusAlcoholType>? alcoholTypeFilter,
    Set<String>? originFilter,
    Set<String>? placeFilter,
    double? minRating,
    double? minAlcohol,
    double? maxAlcohol,
    String? queryString,
  }) {
    return FilterDegustationState(
      degusItems: degusItems ?? this.degusItems,
      degusItemsFiltered: degusItemsFiltered ?? this.degusItemsFiltered,
      searchActive: searchActive ?? this.searchActive,
      availableAlcoholTypes:
          availableAlcoholTypes ?? this.availableAlcoholTypes,
      availableOrigins: availableOrigins ?? this.availableOrigins,
      availablePlaces: availablePlaces ?? this.availablePlaces,
      alcoholTypeFilter: alcoholTypeFilter ?? this.alcoholTypeFilter,
      originFilter: originFilter ?? this.originFilter,
      placeFilter: placeFilter ?? this.placeFilter,
      minRating: minRating ?? this.minRating,
      minAlcohol: minAlcohol ?? this.minAlcohol,
      maxAlcohol: maxAlcohol ?? this.maxAlcohol,
      queryString: queryString ?? this.queryString,
    );
  }
}
