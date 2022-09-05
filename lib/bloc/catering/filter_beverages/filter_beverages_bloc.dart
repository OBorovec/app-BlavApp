import 'dart:async';

import 'package:blavapp/bloc/catering/data_catering/catering_bloc.dart';
import 'package:blavapp/model/catering.dart';
import 'package:diacritic/diacritic.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'filter_beverages_event.dart';
part 'filter_beverages_state.dart';

class FilterBeveragesBloc
    extends Bloc<FilterBeverageEvent, FilterBeveragesState> {
  late final StreamSubscription<CateringState> _cateringBlocSubscription;

  FilterBeveragesBloc({
    required CateringBloc cateringBloc,
  }) : super(FilterBeveragesState(
          items: cateringBloc.state.beverageItems,
          itemsFiltered: cateringBloc.state.beverageItems,
        )) {
    _cateringBlocSubscription = cateringBloc.stream.listen(
      (CateringState state) {
        add(
          UpdateBeverageItems(
            items: state.beverageItems,
          ),
        );
      },
    );
    on<UpdateBeverageItems>(_updateCaterItems);
    // Event listeners
    on<ToggleBeverageSearch>(_toggleSearch);
    on<SetBeverageAvailableFilters>(_setAvailableFilters);
    on<ApplyBeverageFilters>(_applyAllFilters);
    on<ResetBeverageFilters>(_resetFilters);
    on<BeverageTypeFilter>(_updateTypeFilter);
    on<BeveragePlaceFilter>(_updatePlaceFilter);
    on<BeverageHotFilter>(_useHotFilter);
    on<BeverageAlcoholicFilter>(_useAlcoholFilter);
    on<BeverageNonAlcoholicFilter>(_useNonAlcoholFilter);
    on<BeverageTextFilter>(_updateTextFilter);

    // Initialise the filters
    add(const SetBeverageAvailableFilters());
  }

  FutureOr<void> _updateCaterItems(
      UpdateBeverageItems event, Emitter<FilterBeveragesState> emit) {
    emit(
      state.copyWith(
        items: event.items,
      ),
    );
    add(const SetBeverageAvailableFilters());
    add(const ApplyBeverageFilters());
  }

  @override
  Future<void> close() {
    _cateringBlocSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _toggleSearch(
    ToggleBeverageSearch event,
    Emitter<FilterBeveragesState> emit,
  ) {
    emit(
      state.copyWith(
        searchActive: !state.searchActive,
      ),
    );
    add(const ResetBeverageFilters());
  }

  FutureOr<void> _setAvailableFilters(
    SetBeverageAvailableFilters event,
    Emitter<FilterBeveragesState> emit,
  ) {
    final Set<BeverageItemType> availableItemTypes = <BeverageItemType>{};
    final Set<String> availablePlaces = <String>{};
    for (final BeverageItem item in state.items) {
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
    Iterable<BeverageItem> beverageItemsFiltering = state.items;
    if (state.onlyHot) {
      beverageItemsFiltering = beverageItemsFiltering.where(
        (BeverageItem item) => item.hot,
      );
    }
    if (state.onlyAlcoholic) {
      beverageItemsFiltering = beverageItemsFiltering.where(
        (BeverageItem item) => item.alcoholic,
      );
    }
    if (state.onlyNonAlcoholic) {
      beverageItemsFiltering = beverageItemsFiltering.where(
        (BeverageItem item) => !item.alcoholic,
      );
    }
    if (state.itemTypeFilter.isNotEmpty) {
      beverageItemsFiltering = beverageItemsFiltering.where(
        (BeverageItem item) => state.itemTypeFilter.contains(item.type),
      );
    }
    if (state.placesFilter.isNotEmpty) {
      beverageItemsFiltering = beverageItemsFiltering.where(
        (BeverageItem item) => item.placeRef.any(
          (String placeRef) => state.placesFilter.contains(placeRef),
        ),
      );
    }
    if (state.queryString.isNotEmpty) {
      beverageItemsFiltering = beverageItemsFiltering.where(
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
        itemsFiltered: beverageItemsFiltering.toList(),
      ),
    );
  }

  FutureOr<void> _resetFilters(
    ResetBeverageFilters event,
    Emitter<FilterBeveragesState> emit,
  ) {
    emit(state.copyWith(
      itemsFiltered: state.items,
      placesFilter: <String>{},
      onlyHot: false,
      onlyAlcoholic: false,
      onlyNonAlcoholic: false,
      queryString: '',
    ));
  }

  FutureOr<void> _updateTypeFilter(
    BeverageTypeFilter event,
    Emitter<FilterBeveragesState> emit,
  ) {
    final Set<BeverageItemType> typeFilter =
        Set<BeverageItemType>.from(state.itemTypeFilter);
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
    add(const ApplyBeverageFilters());
  }

  FutureOr<void> _updatePlaceFilter(
    BeveragePlaceFilter event,
    Emitter<FilterBeveragesState> emit,
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
    add(const ApplyBeverageFilters());
  }

  FutureOr<void> _useHotFilter(
    BeverageHotFilter event,
    Emitter<FilterBeveragesState> emit,
  ) {
    emit(
      state.copyWith(
        onlyHot: event.value,
      ),
    );
    add(const ApplyBeverageFilters());
  }

  FutureOr<void> _useAlcoholFilter(
    BeverageAlcoholicFilter event,
    Emitter<FilterBeveragesState> emit,
  ) {
    emit(
      state.copyWith(
        onlyAlcoholic: event.value,
        onlyNonAlcoholic: event.value ? false : state.onlyNonAlcoholic,
      ),
    );
    add(const ApplyBeverageFilters());
  }

  FutureOr<void> _useNonAlcoholFilter(
    BeverageNonAlcoholicFilter event,
    Emitter<FilterBeveragesState> emit,
  ) {
    emit(
      state.copyWith(
        onlyNonAlcoholic: event.value,
        onlyAlcoholic: event.value ? false : state.onlyAlcoholic,
      ),
    );
    add(const ApplyBeverageFilters());
  }

  FutureOr<void> _updateTextFilter(
    BeverageTextFilter event,
    Emitter<FilterBeveragesState> emit,
  ) {
    emit(
      state.copyWith(
        queryString: event.text,
      ),
    );
    add(const ApplyBeverageFilters());
  }
}
