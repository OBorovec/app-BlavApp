import 'dart:async';

import 'package:blavapp/bloc/degustation/data_degustation/degustation_bloc.dart';
import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/model/degustation.dart';
import 'package:diacritic/diacritic.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'filter_degustation_event.dart';
part 'filter_degustation_state.dart';

class FilterDegustationBloc
    extends Bloc<FilterDegustationEvent, FilterDegustationState> {
  late final StreamSubscription<DegustationState> _degustationBlocSubscription;
  late final StreamSubscription<UserDataState> _userDataBlocSubscription;

  FilterDegustationBloc({
    required DegustationBloc degustationBloc,
    required UserDataBloc userDataBloc,
  }) : super(FilterDegustationState(
          degusItems: degustationBloc.state.degustationItems,
          myFavoriteItemRefs: userDataBloc.state.userData.favoriteSamples,
          degusItemsFiltered: degustationBloc.state.degustationItems,
        )) {
    _degustationBlocSubscription = degustationBloc.stream.listen(
      (DegustationState state) {
        add(
          UpdateDegusItems(
            degusItems: state.degustationItems,
          ),
        );
      },
    );
    _userDataBlocSubscription = userDataBloc.stream.listen(
      (UserDataState state) => add(
        UpdateMyFavoriteItemRefs(
          myFavoriteItemRefs: state.userData.favoriteSamples,
        ),
      ),
    );
    // Event listeners
    on<UpdateDegusItems>(_updateDegusItems);
    on<UpdateMyFavoriteItemRefs>(_updateMyFavoriteItemRefs);
    on<ToggleSearch>(_toggleSearch);
    on<SetAvailableFilters>(_setAvailableFilters);
    on<ApplyDegusFilters>(_applyAllFilters);
    on<ResetDegusFilters>(_resetAllFilters);
    on<UseMyFavoriteFilter>(_useMyFavoriteFilter);
    on<DegusAlcoholTypeFilter>(_updateAlcoholTypeFilter);
    on<DegusOriginFilter>(_updateOriginFilter);
    on<DegusPlaceFilter>(_updatePlaceFilter);
    on<DegusRatingFilter>(_updateRatingFilter);
    on<DegusAlcoholFilter>(_updateAlcoholFilter);
    on<DegusTextFilter>(_updateTextFilter);
    // Initialise the filters
    add(const SetAvailableFilters());
  }

  FutureOr<void> _updateDegusItems(
      UpdateDegusItems event, Emitter<FilterDegustationState> emit) {
    emit(
      state.copyWith(
        degusItems: event.degusItems,
      ),
    );
    add(const SetAvailableFilters());
    add(const ApplyDegusFilters());
  }

  FutureOr<void> _updateMyFavoriteItemRefs(
    UpdateMyFavoriteItemRefs event,
    Emitter<FilterDegustationState> emit,
  ) {
    emit(
      state.copyWith(
        myFavoriteItemRefs: event.myFavoriteItemRefs,
      ),
    );
    add(const ApplyDegusFilters());
  }

  FutureOr<void> _toggleSearch(
    ToggleSearch event,
    Emitter<FilterDegustationState> emit,
  ) {
    emit(
      state.copyWith(
        searchActive: !state.searchActive,
      ),
    );
    add(const ResetDegusFilters());
  }

  FutureOr<void> _setAvailableFilters(
    SetAvailableFilters event,
    Emitter<FilterDegustationState> emit,
  ) {
    final Set<DegusAlcoholType> availableAlcoholTypes = <DegusAlcoholType>{};
    final Set<String> availableOrigins = <String>{};
    final Set<String> availablePlaces = <String>{};
    for (final DegusItem item in state.degusItems) {
      availableAlcoholTypes.add(item.type);
      if (item.origin != null) availableOrigins.add(item.origin!);
      for (final String place in item.placeRef) {
        availablePlaces.add(place);
      }
    }
    emit(state.copyWith(
      availableAlcoholTypes: availableAlcoholTypes,
      availableOrigins: availableOrigins,
      availablePlaces: availablePlaces,
    ));
  }

  FutureOr<void> _applyAllFilters(
    ApplyDegusFilters event,
    Emitter<FilterDegustationState> emit,
  ) {
    Iterable<DegusItem> itemFiltering = state.degusItems;
    if (state.onlyMyFavorite) {
      itemFiltering = itemFiltering.where(
        (DegusItem item) => state.myFavoriteItemRefs.contains(item.id),
      );
    }
    if (state.alcoholTypeFilter.isNotEmpty) {
      itemFiltering = itemFiltering.where(
        (DegusItem item) => state.alcoholTypeFilter.contains(item.type),
      );
    }
    if (state.originFilter.isNotEmpty) {
      itemFiltering = itemFiltering.where(
        (DegusItem item) => state.originFilter.contains(item.origin),
      );
    }
    if (state.placeFilter.isNotEmpty) {
      itemFiltering = itemFiltering.where(
        (DegusItem item) => state.placeFilter.contains(item.placeRef),
      );
    }
    if (state.queryString.isNotEmpty) {
      itemFiltering = itemFiltering.where(
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
        degusItemsFiltered: itemFiltering.toList(),
      ),
    );
  }

  FutureOr<void> _resetAllFilters(
    ResetDegusFilters event,
    Emitter<FilterDegustationState> emit,
  ) {
    emit(state.copyWith(
      degusItemsFiltered: state.degusItems,
      alcoholTypeFilter: const {},
      originFilter: const {},
      placeFilter: const {},
      minRating: 0,
      minAlcohol: 0,
      maxAlcohol: 100,
      queryString: '',
    ));
  }

  FutureOr<void> _useMyFavoriteFilter(
    UseMyFavoriteFilter event,
    Emitter<FilterDegustationState> emit,
  ) {
    emit(state.copyWith(
      onlyMyFavorite: event.value,
    ));
    add(const ApplyDegusFilters());
  }

  FutureOr<void> _updateAlcoholTypeFilter(
    DegusAlcoholTypeFilter event,
    Emitter<FilterDegustationState> emit,
  ) {
    final Set<DegusAlcoholType> filters =
        Set<DegusAlcoholType>.from(state.alcoholTypeFilter);
    if (filters.contains(event.type)) {
      filters.remove(event.type);
    } else {
      filters.add(event.type);
    }
    emit(
      state.copyWith(
        alcoholTypeFilter: filters,
      ),
    );
    add(const ApplyDegusFilters());
  }

  FutureOr<void> _updateOriginFilter(
    DegusOriginFilter event,
    Emitter<FilterDegustationState> emit,
  ) {
    final Set<String> filters = Set<String>.from(state.originFilter);
    if (filters.contains(event.origin)) {
      filters.remove(event.origin);
    } else {
      filters.add(event.origin);
    }
    emit(
      state.copyWith(
        originFilter: filters,
      ),
    );
    add(const ApplyDegusFilters());
  }

  FutureOr<void> _updatePlaceFilter(
    DegusPlaceFilter event,
    Emitter<FilterDegustationState> emit,
  ) {
    final Set<String> filters = Set<String>.from(state.placeFilter);
    if (filters.contains(event.place)) {
      filters.remove(event.place);
    } else {
      filters.add(event.place);
    }
    emit(
      state.copyWith(
        placeFilter: filters,
      ),
    );
    add(const ApplyDegusFilters());
  }

  FutureOr<void> _updateRatingFilter(
    DegusRatingFilter event,
    Emitter<FilterDegustationState> emit,
  ) {
    emit(state.copyWith(
      minRating: event.score,
    ));
    add(const ApplyDegusFilters());
  }

  FutureOr<void> _updateAlcoholFilter(
    DegusAlcoholFilter event,
    Emitter<FilterDegustationState> emit,
  ) {
    emit(state.copyWith(
      minAlcohol: event.min,
      maxAlcohol: event.max,
    ));
    add(const ApplyDegusFilters());
  }

  FutureOr<void> _updateTextFilter(
    DegusTextFilter event,
    Emitter<FilterDegustationState> emit,
  ) {
    emit(
      state.copyWith(
        queryString: event.text,
      ),
    );
    add(const ApplyDegusFilters());
  }

  @override
  Future<void> close() {
    _degustationBlocSubscription.cancel();
    _userDataBlocSubscription.cancel();
    return super.close();
  }
}
