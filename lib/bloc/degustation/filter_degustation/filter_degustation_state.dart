part of 'filter_degustation_bloc.dart';

class FilterDegustationState extends Equatable {
  final List<DegusItem> degusItems;
  final Set<String> myFavoriteItemRefs;
  final Set<String> tastedItemRefs;
  // Control
  final bool searchActive;
  //Filtered entry list
  final List<DegusItem> degusItemsFiltered;
  // Filter options
  final Set<DegusAlcoholType> availableAlcoholTypes;
  final Set<String> availableOrigins;
  final Set<String> availablePlaces;
  // Filters
  final bool exploreMode;
  final bool onlyMyFavorite;
  final Set<DegusAlcoholType> alcoholTypeFilter;
  final Set<String> originFilter;
  final Set<String> placeFilter;
  final double minRating;
  final double minAlcohol;
  final double maxAlcohol;
  final String queryString;

  const FilterDegustationState({
    required this.degusItems,
    required this.myFavoriteItemRefs,
    required this.tastedItemRefs,
    this.searchActive = false,
    required this.degusItemsFiltered,
    this.availableAlcoholTypes = const {},
    this.availableOrigins = const {},
    this.availablePlaces = const {},
    this.exploreMode = false,
    this.onlyMyFavorite = false,
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
        myFavoriteItemRefs,
        tastedItemRefs,
        searchActive,
        degusItemsFiltered,
        availableAlcoholTypes,
        availableOrigins,
        availablePlaces,
        exploreMode,
        onlyMyFavorite,
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
    Set<String>? myFavoriteItemRefs,
    Set<String>? tastedItemRefs,
    bool? searchActive,
    List<DegusItem>? degusItemsFiltered,
    Set<DegusAlcoholType>? availableAlcoholTypes,
    Set<String>? availableOrigins,
    Set<String>? availablePlaces,
    bool? exploreMode,
    bool? onlyMyFavorite,
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
      myFavoriteItemRefs: myFavoriteItemRefs ?? this.myFavoriteItemRefs,
      tastedItemRefs: tastedItemRefs ?? this.tastedItemRefs,
      searchActive: searchActive ?? this.searchActive,
      degusItemsFiltered: degusItemsFiltered ?? this.degusItemsFiltered,
      availableAlcoholTypes:
          availableAlcoholTypes ?? this.availableAlcoholTypes,
      availableOrigins: availableOrigins ?? this.availableOrigins,
      availablePlaces: availablePlaces ?? this.availablePlaces,
      exploreMode: exploreMode ?? this.exploreMode,
      onlyMyFavorite: onlyMyFavorite ?? this.onlyMyFavorite,
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
