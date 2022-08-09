part of 'highlight_degustation_bloc.dart';

class HighlightDegustationState extends Equatable {
  // Bloc data
  final List<DegusItem> degustationItems;
  final Set<String> myFavorite;
  final Map<String, double?> myRatings;
  // Computed data
  final Set<String> myDegustationFavorite;
  final Map<String, double?> myDegustationRatings;
  // View Data
  final Map<String, String>? headerText;
  final int totalSamples;
  final int totalFavorites;
  final int totalRated;
  final List<DegusItem> bestRated;
  final List<DegusItem> recommendations;

  const HighlightDegustationState({
    this.degustationItems = const <DegusItem>[],
    this.myFavorite = const <String>{},
    this.myRatings = const <String, double>{},
    this.myDegustationFavorite = const <String>{},
    this.myDegustationRatings = const <String, double>{},
    this.headerText,
    this.totalSamples = 0,
    this.totalFavorites = 0,
    this.totalRated = 0,
    this.bestRated = const <DegusItem>[],
    this.recommendations = const <DegusItem>[],
  });

  @override
  List<Object> get props => [
        degustationItems,
        myFavorite,
        myRatings,
        totalSamples,
        totalFavorites,
        totalRated,
        bestRated,
        recommendations,
      ];

  HighlightDegustationState copyWith({
    List<DegusItem>? degustationItems,
    Set<String>? myFavorite,
    Map<String, double?>? myRatings,
    Set<String>? myDegustationFavorite,
    Map<String, double?>? myDegustationRatings,
    Map<String, String>? headerText,
    int? totalSamples,
    int? totalFavorites,
    int? totalRated,
    List<DegusItem>? bestRated,
    List<DegusItem>? recommendations,
  }) {
    return HighlightDegustationState(
      degustationItems: degustationItems ?? this.degustationItems,
      myFavorite: myFavorite ?? this.myFavorite,
      myRatings: myRatings ?? this.myRatings,
      myDegustationFavorite:
          myDegustationFavorite ?? this.myDegustationFavorite,
      myDegustationRatings: myDegustationRatings ?? this.myDegustationRatings,
      headerText: headerText ?? this.headerText,
      totalSamples: totalSamples ?? this.totalSamples,
      totalFavorites: totalFavorites ?? this.totalFavorites,
      totalRated: totalRated ?? this.totalRated,
      bestRated: bestRated ?? this.bestRated,
      recommendations: recommendations ?? this.recommendations,
    );
  }
}
