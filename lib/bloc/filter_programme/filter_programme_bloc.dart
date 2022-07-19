import 'dart:async';

import 'package:blavapp/bloc/data_programme/programme_bloc.dart';
import 'package:blavapp/bloc/user_data/user_data_bloc.dart';
import 'package:blavapp/model/prog_entry.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'filter_programme_event.dart';
part 'filter_programme_state.dart';

class FilterProgrammeBloc
    extends Bloc<FilterProgrammeEvent, FilterProgrammeState> {
  late final StreamSubscription<ProgrammeState> _programmeBlocSubscription;
  late final StreamSubscription<UserDataState> _userDataBlocSubscription;

  FilterProgrammeBloc({
    required ProgrammeBloc programmeBloc,
    required UserDataBloc userDataBloc,
  }) : super(FilterProgrammeState(
          programmeEntries: programmeBloc.state.programmeEntries,
          programmeEntriesFiltered: programmeBloc.state.programmeEntries,
          myProgrammeEntryIds: userDataBloc.state.usedData.myProgramme,
        )) {
    _programmeBlocSubscription = programmeBloc.stream.listen(
      (ProgrammeState state) {
        add(
          UpdateProgrammeEntries(
            programmeEntries: state.programmeEntries,
          ),
        );
      },
    );
    _userDataBlocSubscription = userDataBloc.stream.listen(
      (UserDataState state) => add(
        UpdateMyProgrammeEntryIds(
          myProgrammeEntryIds: state.usedData.myProgramme,
        ),
      ),
    );
    // Event listeners
    on<UpdateProgrammeEntries>(_updateProgrammeEntries);
    on<UpdateMyProgrammeEntryIds>(_updateMyProgrammeEntryIds);
    on<SetAvailableFilters>(_setAvailableFilters);
    on<ApplyProgrammeFilters>(_applyAllFilters);
    on<ResetProgrammeFilters>(_resetAllFilters);
    on<UseMyProgrammeFilter>(_useMyProgrammeFilter);
    on<ProgrammeDateFilter>(_updateDateFilter);
    on<ProgrammeTypeFilter>(_updateTypeFilter);
    on<ProgrammePlaceFilter>(_updatePlaceFilter);
    on<ProgrammeTextFilter>(_updateTextFilter);
    // Initialise the filters
    add(const SetAvailableFilters());
  }

  FutureOr<void> _updateProgrammeEntries(
    UpdateProgrammeEntries event,
    Emitter<FilterProgrammeState> emit,
  ) {
    emit(
      state.copyWith(
        programmeEntries: event.programmeEntries,
        programmeEntriesFiltered: event.programmeEntries,
      ),
    );
    add(const SetAvailableFilters());
    add(const ApplyProgrammeFilters());
  }

  FutureOr<void> _updateMyProgrammeEntryIds(
    UpdateMyProgrammeEntryIds event,
    Emitter<FilterProgrammeState> emit,
  ) {
    emit(
      state.copyWith(
        myProgrammeEntryIds: event.myProgrammeEntryIds,
      ),
    );
    add(const ApplyProgrammeFilters());
  }

  FutureOr<void> _setAvailableFilters(
    SetAvailableFilters event,
    Emitter<FilterProgrammeState> emit,
  ) {
    final Set<DateTime> availableDates = <DateTime>{};
    final Set<ProgEntryType> availableEventTypes = <ProgEntryType>{};
    final Set<String> availableEventPlaces = <String>{};
    for (final ProgEntry entry in state.programmeEntries) {
      availableDates.add(
        DateTime(
          entry.timestamp.year,
          entry.timestamp.month,
          entry.timestamp.day,
        ),
      );
      availableEventTypes.add(entry.type);
      availableEventPlaces.add(entry.placeRef ?? '');
    }
    emit(
      state.copyWith(
        availableDates: availableDates,
        availableEntryTypes: availableEventTypes,
        availableEntryPlaces: availableEventPlaces,
      ),
    );
  }

  Future<void> _applyAllFilters(event, emit) async {
    Iterable<ProgEntry> programmeFiltering = state.programmeEntries;
    if (state.onlyMyProgramme) {
      programmeFiltering = programmeFiltering.where(
        (ProgEntry entry) => state.myProgrammeEntryIds.contains(entry.id),
      );
    }
    if (state.entryTypeFilter.isNotEmpty) {
      programmeFiltering = programmeFiltering
          .where((e) => state.entryTypeFilter.contains(e.type));
    }
    if (state.entryPlacesFilter.isNotEmpty) {
      programmeFiltering = programmeFiltering
          .where((e) => state.entryPlacesFilter.contains(e.placeRef));
    }
    if (state.dateFilter.isNotEmpty) {
      programmeFiltering = programmeFiltering.where(
        (e) => state.dateFilter.contains(
          DateTime(
            e.timestamp.year,
            e.timestamp.month,
            e.timestamp.day,
          ),
        ),
      );
    }
    if (state.queryString.isNotEmpty) {
      programmeFiltering = programmeFiltering.where(
        (e) => e
            .toJson()
            .toString()
            .toLowerCase()
            .contains(state.queryString.toLowerCase()),
      );
    }
    emit(
      state.copyWith(
        programmeEntriesFiltered: programmeFiltering.toList(),
      ),
    );
  }

  Future<void> _resetAllFilters(event, emit) async {
    emit(
      state.copyWith(
        dateFilter: <DateTime>{},
        entryTypeFilter: <ProgEntryType>{},
        entryPlacesFilter: <String>{},
        queryString: '',
      ),
    );
  }

  FutureOr<void> _useMyProgrammeFilter(
    UseMyProgrammeFilter event,
    Emitter<FilterProgrammeState> emit,
  ) {
    emit(
      state.copyWith(
        onlyMyProgramme: event.value,
      ),
    );
    add(const ApplyProgrammeFilters());
  }

  Future<void> _updateDateFilter(
    ProgrammeDateFilter event,
    emit,
  ) async {
    final Set<DateTime> dateFilter = Set.from(state.dateFilter);
    if (dateFilter.contains(event.date)) {
      dateFilter.remove(event.date);
    } else {
      dateFilter.add(event.date);
    }
    emit(
      state.copyWith(
        dateFilter: dateFilter,
      ),
    );
    add(const ApplyProgrammeFilters());
  }

  Future<void> _updateTypeFilter(
    ProgrammeTypeFilter event,
    emit,
  ) async {
    final Set<ProgEntryType> entryTypeFilter = Set.from(state.entryTypeFilter);
    if (entryTypeFilter.contains(event.type)) {
      entryTypeFilter.remove(event.type);
    } else {
      entryTypeFilter.add(event.type);
    }
    emit(
      state.copyWith(
        entryTypeFilter: entryTypeFilter,
      ),
    );
    add(const ApplyProgrammeFilters());
  }

  Future<void> _updatePlaceFilter(
    ProgrammePlaceFilter event,
    emit,
  ) async {
    final Set<String> entryPlacesFilter = Set.from(state.entryPlacesFilter);
    if (entryPlacesFilter.contains(event.placeID)) {
      entryPlacesFilter.remove(event.placeID);
    } else {
      entryPlacesFilter.add(event.placeID);
    }
    emit(
      state.copyWith(
        entryPlacesFilter: entryPlacesFilter,
      ),
    );
    add(const ApplyProgrammeFilters());
  }

  Future<void> _updateTextFilter(
    ProgrammeTextFilter event,
    emit,
  ) async {
    emit(
      state.copyWith(
        queryString: event.text,
      ),
    );
    add(const ApplyProgrammeFilters());
  }

  @override
  Future<void> close() {
    _programmeBlocSubscription.cancel();
    _userDataBlocSubscription.cancel();
    return super.close();
  }
}
