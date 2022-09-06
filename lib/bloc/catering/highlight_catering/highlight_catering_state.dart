part of 'highlight_catering_bloc.dart';

class HighlightPlaceCardData {
  final CaterPlace place;
  final bool isOpen;

  HighlightPlaceCardData({
    required this.place,
    required this.isOpen,
  });
}

class HighlightCateringState extends Equatable {
  // Bloc data
  final List<MealItem> mealItems;
  final Map<String, CaterPlace> cateringPlaces;
  final Set<String> myFavorite;
  // Computed data
  // View Data
  final Map<String, String>? headerText;
  final int totalPlaces;
  final int totalItems;
  final List<HighlightPlaceCardData> placeCardData;

  const HighlightCateringState({
    this.mealItems = const <MealItem>[],
    this.cateringPlaces = const <String, CaterPlace>{},
    this.myFavorite = const <String>{},
    this.headerText,
    this.totalPlaces = 0,
    this.totalItems = 0,
    this.placeCardData = const <HighlightPlaceCardData>[],
  });

  @override
  List<Object> get props => [
        mealItems,
        cateringPlaces,
        myFavorite,
        totalPlaces,
        totalItems,
        placeCardData,
      ];

  HighlightCateringState copyWith({
    List<MealItem>? cateringItems,
    Map<String, CaterPlace>? cateringPlaces,
    Set<String>? myFavorite,
    Map<String, String>? headerText,
    int? totalPlaces,
    int? totalItems,
    List<HighlightPlaceCardData>? placeCardData,
  }) {
    return HighlightCateringState(
      mealItems: cateringItems ?? this.mealItems,
      cateringPlaces: cateringPlaces ?? this.cateringPlaces,
      myFavorite: myFavorite ?? this.myFavorite,
      headerText: headerText ?? this.headerText,
      totalPlaces: totalPlaces ?? this.totalPlaces,
      totalItems: totalItems ?? this.totalItems,
      placeCardData: placeCardData ?? this.placeCardData,
    );
  }
}
