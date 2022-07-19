part of 'filter_catering_bloc.dart';

abstract class FilterCateringEvent extends Equatable {
  const FilterCateringEvent();

  @override
  List<Object> get props => [];
}

class UpdateCaterItems extends FilterCateringEvent {
  final List<CaterItem> cateringItems;

  const UpdateCaterItems({
    required this.cateringItems,
  });
}

class SetAvailableFilters extends FilterCateringEvent {
  const SetAvailableFilters();
}

class ApplyCateringFilters extends FilterCateringEvent {
  const ApplyCateringFilters();
}

class ResetCateringFilters extends FilterCateringEvent {
  const ResetCateringFilters();
}

class CateringTypeFilter extends FilterCateringEvent {
  final CaterItemType type;

  const CateringTypeFilter(this.type);
}

class CateringPlaceFilter extends FilterCateringEvent {
  final String place;

  const CateringPlaceFilter(this.place);
}

class CateringAllergenFilter extends FilterCateringEvent {
  final int allergen;

  const CateringAllergenFilter(this.allergen);
}

class UseCateringVegetarianFilter extends FilterCateringEvent {
  final bool value;

  const UseCateringVegetarianFilter(this.value);
}

class UseCateringVeganFilter extends FilterCateringEvent {
  final bool value;

  const UseCateringVeganFilter(this.value);
}

class UseCateringGlutenFreeFilter extends FilterCateringEvent {
  final bool value;

  const UseCateringGlutenFreeFilter(this.value);
}

class CateringTextFilter extends FilterCateringEvent {
  final String text;

  const CateringTextFilter(this.text);
}
