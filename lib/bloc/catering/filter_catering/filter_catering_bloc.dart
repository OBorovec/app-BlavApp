import 'dart:async';

import 'package:blavapp/bloc/catering/data_catering/catering_bloc.dart';
import 'package:blavapp/model/catering.dart';
import 'package:bloc/bloc.dart';
import 'package:diacritic/diacritic.dart';
import 'package:equatable/equatable.dart';

part 'filter_catering_event.dart';
part 'filter_catering_state.dart';

class FilterCateringBloc
    extends Bloc<FilterCateringEvent, FilterCateringState> {
  late final StreamSubscription<CateringState> _cateringBlocSubscription;

  FilterCateringBloc({
    required CateringBloc cateringBloc,
  }) : super(FilterCateringState(
          cateringItems: cateringBloc.state.cateringItems,
          cateringItemsFiltered: cateringBloc.state.cateringItems,
        )) {
    _cateringBlocSubscription = cateringBloc.stream.listen(
      (CateringState state) {
        add(
          UpdateCaterItems(
            cateringItems: state.cateringItems,
          ),
        );
      },
    );
    // Event listeners
    on<UpdateCaterItems>(_updateCaterItems);
    on<ToggleSearch>(_toggleSearch);
    on<SetAvailableFilters>(_setAvailableFilters);
    on<ApplyCateringFilters>(_applyAllFilters);
    on<ResetCateringFilters>(_resetAllFilters);
    on<CateringTypeFilter>(_updateTypeFilter);
    on<CateringPlaceFilter>(_updatePlaceFilter);
    on<CateringAllergenFilter>(_updateAllergenFilter);
    on<UseCateringVegetarianFilter>(_useVegetarianFilter);
    on<UseCateringVeganFilter>(_useVeganFilter);
    on<UseCateringGlutenFreeFilter>(_useGlutenFreeFilter);
    on<CateringTextFilter>(_updateTextFilter);
    // Initialise the filters
    add(const SetAvailableFilters());
  }

  FutureOr<void> _updateCaterItems(
      UpdateCaterItems event, Emitter<FilterCateringState> emit) {
    emit(
      state.copyWith(
        cateringItems: event.cateringItems,
      ),
    );
    add(const SetAvailableFilters());
    add(const ApplyCateringFilters());
  }

  FutureOr<void> _toggleSearch(
    ToggleSearch event,
    Emitter<FilterCateringState> emit,
  ) {
    emit(
      state.copyWith(
        searchActive: !state.searchActive,
      ),
    );
    add(const ResetCateringFilters());
  }

  FutureOr<void> _setAvailableFilters(
    SetAvailableFilters event,
    Emitter<FilterCateringState> emit,
  ) {
    final Set<CaterItemType> availableItemTypes = <CaterItemType>{};
    final Set<String> availablePlaces = <String>{};
    for (final CaterItem item in state.cateringItems) {
      availableItemTypes.add(item.type);
      if (item.placeRef != null) {
        availablePlaces.add(item.placeRef!);
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
    Iterable<CaterItem> caterItemsFiltering = state.cateringItems;
    if (state.onlyVegetarian) {
      caterItemsFiltering = caterItemsFiltering.where(
        (CaterItem item) => item.vegetarian,
      );
    }
    if (state.onlyVegan) {
      caterItemsFiltering = caterItemsFiltering.where(
        (CaterItem item) => item.vegan,
      );
    }
    if (state.onlyGlutenFree) {
      caterItemsFiltering = caterItemsFiltering.where(
        (CaterItem item) => item.glutenFree,
      );
    }
    if (state.itemTypeFilter.isNotEmpty) {
      caterItemsFiltering = caterItemsFiltering.where(
        (CaterItem item) => state.itemTypeFilter.contains(item.type),
      );
    }
    if (state.placesFilter.isNotEmpty) {
      caterItemsFiltering = caterItemsFiltering.where(
        (CaterItem item) => state.placesFilter.contains(item.placeRef),
      );
    }
    if (state.allergensFilter.isNotEmpty) {
      caterItemsFiltering = caterItemsFiltering.where(
        (CaterItem item) =>
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
    ResetCateringFilters event,
    Emitter<FilterCateringState> emit,
  ) {
    emit(state.copyWith(
      cateringItemsFiltered: state.cateringItems,
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
    Emitter<FilterCateringState> emit,
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
    add(const ApplyCateringFilters());
  }

  FutureOr<void> _updatePlaceFilter(
    CateringPlaceFilter event,
    Emitter<FilterCateringState> emit,
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
    add(const ApplyCateringFilters());
  }

  FutureOr<void> _updateAllergenFilter(
    CateringAllergenFilter event,
    Emitter<FilterCateringState> emit,
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
    add(const ApplyCateringFilters());
  }

  FutureOr<void> _useVegetarianFilter(
    UseCateringVegetarianFilter event,
    Emitter<FilterCateringState> emit,
  ) {
    emit(
      state.copyWith(
        onlyVegetarian: event.value,
      ),
    );
    add(const ApplyCateringFilters());
  }

  FutureOr<void> _useVeganFilter(
    UseCateringVeganFilter event,
    Emitter<FilterCateringState> emit,
  ) {
    emit(
      state.copyWith(
        onlyVegan: event.value,
      ),
    );
    add(const ApplyCateringFilters());
  }

  FutureOr<void> _useGlutenFreeFilter(
    UseCateringGlutenFreeFilter event,
    Emitter<FilterCateringState> emit,
  ) {
    emit(
      state.copyWith(
        onlyGlutenFree: event.value,
      ),
    );
  }

  FutureOr<void> _updateTextFilter(
    CateringTextFilter event,
    Emitter<FilterCateringState> emit,
  ) {
    emit(
      state.copyWith(
        queryString: event.text,
      ),
    );
    add(const ApplyCateringFilters());
  }

  @override
  Future<void> close() {
    _cateringBlocSubscription.cancel();
    return super.close();
  }
}
