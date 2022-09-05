part of 'highlight_catering_bloc.dart';

abstract class HighlightCateringEvent extends Equatable {
  const HighlightCateringEvent();

  @override
  List<Object> get props => [];
}

class UpdateCatering extends HighlightCateringEvent {
  final Map<String, String>? desc;
  final List<MealItem> mealItems;
  final Map<String, CaterPlace> caterPlaces;

  const UpdateCatering({
    this.desc,
    required this.mealItems,
    required this.caterPlaces,
  });
}

class UpdateUserData extends HighlightCateringEvent {
  final Set<String> myFavorite;

  const UpdateUserData({
    required this.myFavorite,
  });
}

class UpdateViewData extends HighlightCateringEvent {
  const UpdateViewData();
}
