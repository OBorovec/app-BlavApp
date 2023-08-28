part of 'highlight_degustation_bloc.dart';

class HighlightPlaceCardData {
  final DegusPlace place;
  final bool isOpen;

  HighlightPlaceCardData({
    required this.place,
    required this.isOpen,
  });
}

class HighlightDegustationState extends Equatable {
  // Bloc data
  final List<DegusItem> degustationItems;
  final Map<String, DegusPlace> degustationPlaces;
  final Set<String> userTasted;
  final Set<String> userFavorite;
  final Map<String, double?> userRatings;
  // Computed data
  final Set<String> myDegustationFavorite;
  final Map<String, double?> myDegustationRatings;
  // View Data
  final Map<String, String>? headerText;
  final int totalSamples;
  final int totalTasted;
  final int totalFavorites;
  final int totalRated;
  final List<HighlightPlaceCardData> placeCardData;
  final List<DegusItem> bestRated;
  final List<DegusItem> similarToLiked;
  final List<DegusItem> recommendations;

  const HighlightDegustationState({
    this.degustationItems = const [],
    this.degustationPlaces = const {},
    this.userTasted = const {},
    this.userFavorite = const {},
    this.userRatings = const {},
    this.myDegustationFavorite = const {},
    this.myDegustationRatings = const {},
    this.headerText,
    this.totalSamples = 0,
    this.totalTasted = 0,
    this.totalFavorites = 0,
    this.totalRated = 0,
    this.placeCardData = const [],
    this.bestRated = const [],
    this.similarToLiked = const [],
    this.recommendations = const [],
  });

  @override
  List<Object> get props => [
        degustationItems,
        degustationPlaces,
        userTasted,
        userFavorite,
        userRatings,
        myDegustationFavorite,
        myDegustationRatings,
        totalSamples,
        totalTasted,
        totalFavorites,
        totalRated,
        placeCardData,
        bestRated,
        similarToLiked,
        recommendations,
      ];

  HighlightDegustationState copyWith({
    List<DegusItem>? degustationItems,
    Map<String, DegusPlace>? degustationPlaces,
    Set<String>? userTasted,
    Set<String>? userFavorite,
    Map<String, double?>? userRatings,
    Set<String>? myDegustationFavorite,
    Map<String, double?>? myDegustationRatings,
    Map<String, String>? headerText,
    int? totalSamples,
    int? totalTasted,
    int? totalFavorites,
    int? totalRated,
    List<HighlightPlaceCardData>? placeCardData,
    List<DegusItem>? bestRated,
    List<DegusItem>? similarToLiked,
    List<DegusItem>? recommendations,
  }) {
    return HighlightDegustationState(
      degustationItems: degustationItems ?? this.degustationItems,
      degustationPlaces: degustationPlaces ?? this.degustationPlaces,
      userTasted: userTasted ?? this.userTasted,
      userFavorite: userFavorite ?? this.userFavorite,
      userRatings: userRatings ?? this.userRatings,
      myDegustationFavorite:
          myDegustationFavorite ?? this.myDegustationFavorite,
      myDegustationRatings: myDegustationRatings ?? this.myDegustationRatings,
      headerText: headerText ?? this.headerText,
      totalSamples: totalSamples ?? this.totalSamples,
      totalTasted: totalTasted ?? this.totalTasted,
      totalFavorites: totalFavorites ?? this.totalFavorites,
      totalRated: totalRated ?? this.totalRated,
      placeCardData: placeCardData ?? this.placeCardData,
      bestRated: bestRated ?? this.bestRated,
      similarToLiked: similarToLiked ?? this.similarToLiked,
      recommendations: recommendations ?? this.recommendations,
    );
  }
}
