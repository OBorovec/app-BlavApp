import 'dart:async';

import 'package:blavapp/bloc/catering/data_catering/catering_bloc.dart';
import 'package:blavapp/model/catering.dart';
import 'package:diacritic/diacritic.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'filter_meals_event.dart';
part 'filter_meals_state.dart';

class FilterMealsBloc extends Bloc<FilterMealEvent, FilterMealsState> {
  late final StreamSubscription<CateringState> _cateringBlocSubscription;

  FilterMealsBloc({
    required CateringBloc cateringBloc,
  }) : super(FilterMealsState(
          items: cateringBloc.state.mealItems,
          itemsFiltered: cateringBloc.state.mealItems,
        )) {
    _cateringBlocSubscription = cateringBloc.stream.listen(
      (CateringState state) {
        add(
          UpdateMealItems(
            items: state.mealItems,
          ),
        );
      },
    );
    on<UpdateMealItems>(_updateCaterItems);
    // Event listeners
    on<ToggleMealSearch>(_toggleSearch);
    on<SetMealAvailableFilters>(_setAvailableFilters);
    on<ApplyMealFilters>(_applyAllFilters);
    on<ResetMealFilters>(_resetAllFilters);
    on<CateringTypeFilter>(_updateTypeFilter);
    on<MealPlaceFilter>(_updatePlaceFilter);
    on<MealAllergenFilter>(_updateAllergenFilter);
    on<MealVegetarianFilter>(_useVegetarianFilter);
    on<MealVeganFilter>(_useVeganFilter);
    on<MealGlutenFreeFilter>(_useGlutenFreeFilter);
    on<MealTextFilter>(_updateTextFilter);
    // Initialise the filters
    add(const SetMealAvailableFilters());
  }

  FutureOr<void> _updateCaterItems(
      UpdateMealItems event, Emitter<FilterMealsState> emit) {
    emit(
      state.copyWith(
        cateringItems: event.items,
      ),
    );
    add(const SetMealAvailableFilters());
    add(const ApplyMealFilters());
  }

  FutureOr<void> _toggleSearch(
    ToggleMealSearch event,
    Emitter<FilterMealsState> emit,
  ) {
    emit(
      state.copyWith(
        searchActive: !state.searchActive,
      ),
    );
    add(const ResetMealFilters());
  }

  @override
  Future<void> close() {
    _cateringBlocSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _setAvailableFilters(
    SetMealAvailableFilters event,
    Emitter<FilterMealsState> emit,
  ) {
    final Set<CaterItemType> availableItemTypes = <CaterItemType>{};
    final Set<String> availablePlaces = <String>{};
    for (final MealItem item in state.items) {
      availableItemTypes.add(item.type);
      for (String placeRef in item.placeRef) {
        availablePlaces.add(placeRef);
      }
    }
    emit(
      state.copyWith(
        availableItemTypes: availableItemTypes,
        availablePlaces: availablePlaces,
      ),
    );
  }

  Future<void> _applyAllFilters(event, emit) async {
    Iterable<MealItem> caterItemsFiltering = state.items;
    if (state.onlyVegetarian) {
      caterItemsFiltering = caterItemsFiltering.where(
        (MealItem item) => item.vegetarian,
      );
    }
    if (state.onlyVegan) {
      caterItemsFiltering = caterItemsFiltering.where(
        (MealItem item) => item.vegan,
      );
    }
    if (state.onlyGlutenFree) {
      caterItemsFiltering = caterItemsFiltering.where(
        (MealItem item) => item.glutenFree,
      );
    }
    if (state.itemTypeFilter.isNotEmpty) {
      caterItemsFiltering = caterItemsFiltering.where(
        (MealItem item) => state.itemTypeFilter.contains(item.type),
      );
    }
    if (state.placesFilter.isNotEmpty) {
      caterItemsFiltering = caterItemsFiltering.where(
        (MealItem item) => item.placeRef.any(
          (String placeRef) => state.placesFilter.contains(placeRef),
        ),
      );
    }
    if (state.allergensFilter.isNotEmpty) {
      caterItemsFiltering = caterItemsFiltering.where(
        (MealItem item) =>
            !item.allergens.any((int e) => state.allergensFilter.contains(e)),
      );
    }
    if (state.queryString.isNotEmpty) {
      caterItemsFiltering = caterItemsFiltering.where(
        (e) => removeDiacritics(
          e.toJson().toString().toLowerCase(),
        ).contains(
          removeDiacritics(
            state.queryString.toLowerCase(),
          ),
        ),
      );
    }
    emit(
      state.copyWith(
        cateringItemsFiltered: caterItemsFiltering.toList(),
      ),
    );
  }

  FutureOr<void> _resetAllFilters(
    ResetMealFilters event,
    Emitter<FilterMealsState> emit,
  ) {
    emit(state.copyWith(
      cateringItemsFiltered: state.items,
      itemTypeFilter: <CaterItemType>{},
      placesFilter: <String>{},
      allergensFilter: <int>{},
      onlyVegetarian: false,
      onlyVegan: false,
      onlyGlutenFree: false,
      queryString: '',
    ));
  }

  FutureOr<void> _updateTypeFilter(
    CateringTypeFilter event,
    Emitter<FilterMealsState> emit,
  ) {
    final Set<CaterItemType> typeFilter =
        Set<CaterItemType>.from(state.itemTypeFilter);
    if (typeFilter.contains(event.type)) {
      typeFilter.remove(event.type);
    } else {
      typeFilter.add(event.type);
    }
    emit(
      state.copyWith(
        itemTypeFilter: typeFilter,
      ),
    );
    add(const ApplyMealFilters());
  }

  FutureOr<void> _updatePlaceFilter(
    MealPlaceFilter event,
    Emitter<FilterMealsState> emit,
  ) {
    final Set<String> placeFilter = Set<String>.from(state.placesFilter);
    if (placeFilter.contains(event.place)) {
      placeFilter.remove(event.place);
    } else {
      placeFilter.add(event.place);
    }
    emit(
      state.copyWith(
        placesFilter: placeFilter,
      ),
    );
    add(const ApplyMealFilters());
  }

  FutureOr<void> _updateAllergenFilter(
    MealAllergenFilter event,
    Emitter<FilterMealsState> emit,
  ) {
    final Set<int> allergensFilter = Set<int>.from(state.allergensFilter);
    if (allergensFilter.contains(event.allergen)) {
      allergensFilter.remove(event.allergen);
    } else {
      allergensFilter.add(event.allergen);
    }
    emit(
      state.copyWith(
        allergensFilter: allergensFilter,
      ),
    );
    add(const ApplyMealFilters());
  }

  FutureOr<void> _useVegetarianFilter(
    MealVegetarianFilter event,
    Emitter<FilterMealsState> emit,
  ) {
    emit(
      state.copyWith(
        onlyVegetarian: event.value,
      ),
    );
    add(const ApplyMealFilters());
  }

  FutureOr<void> _useVeganFilter(
    MealVeganFilter event,
    Emitter<FilterMealsState> emit,
  ) {
    emit(
      state.copyWith(
        onlyVegan: event.value,
      ),
    );
    add(const ApplyMealFilters());
  }

  FutureOr<void> _useGlutenFreeFilter(
    MealGlutenFreeFilter event,
    Emitter<FilterMealsState> emit,
  ) {
    emit(
      state.copyWith(
        onlyGlutenFree: event.value,
      ),
    );
    add(const ApplyMealFilters());
  }

  FutureOr<void> _updateTextFilter(
    MealTextFilter event,
    Emitter<FilterMealsState> emit,
  ) {
    emit(
      state.copyWith(
        queryString: event.text,
      ),
    );
    add(const ApplyMealFilters());
  }
}
