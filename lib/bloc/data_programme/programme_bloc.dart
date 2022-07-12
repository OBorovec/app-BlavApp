import 'dart:async';
import 'package:blavapp/bloc/user_data/user_data_bloc.dart';
import 'package:blavapp/model/prog_entry.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'programme_event.dart';
part 'programme_state.dart';

class ProgrammeBloc extends Bloc<ProgrammeEvent, ProgrammeState> {
  final DataRepo _dataRepo;
  final UserDataBloc _userDataBloc;
  late final StreamSubscription<UserDataState> _userDataBlocSubscription;
  late final StreamSubscription<List<ProgEntry>> _programmeEntries;

  ProgrammeBloc({
    required DataRepo dataRepo,
    required UserDataBloc userDataBloc,
    required String eventTag,
  })  : _dataRepo = dataRepo,
        _userDataBloc = userDataBloc,
        super(
          const ProgrammeInitial(),
        ) {
    _userDataBlocSubscription = userDataBloc.stream.listen(
      (UserDataState state) => add(
        UpdateMyProgrammeList(
          programmeEntryIds: state.usedData.myProgramme,
        ),
      ),
    );
    _programmeEntries = _dataRepo
        .getProgItemsStream(eventTag)
        .listen((List<ProgEntry> programmeEntries) => add(
              ProgrammeStreamChanged(
                programmeEntries: programmeEntries,
              ),
            ));
    // ..onError((error) {
    //   add(ProgrammeSubscriptionFailed(error.toString()));
    // });
    // Event listeners
    on<UpdateMyProgrammeList>(_onUpdateMyProgrammeList);
    on<ProgrammeSubscriptionFailed>(_onFailure);
    on<ProgrammeStreamChanged>(_onProgEntriesChange);
    on<ApplyProgrammeFilters>(_applyAllFilters);
    on<ResetProgrammeFilters>(_resetAllFilters);
    on<UseMyProgrammeFilter>(_useMyProgrammeFilter);
    on<ProgrammeDateFilter>(_updateDateFilter);
    on<ProgrammeTypeFilter>(_updateTypeFilter);
    on<ProgrammePlaceFilter>(_updatePlaceFilter);
    on<ProgrammeTextFilter>(_updateTextFilter);
  }

  FutureOr<void> _onUpdateMyProgrammeList(
    UpdateMyProgrammeList event,
    Emitter<ProgrammeState> emit,
  ) {}

  Future<void> _onFailure(ProgrammeSubscriptionFailed event, emit) async {
    emit(
      ProgrammeFailState(event.message),
    );
  }

  Future<void> _onProgEntriesChange(ProgrammeStreamChanged event, emit) async {
    try {
      final Set<DateTime> availableDates = <DateTime>{};
      final Set<ProgEntryType> availableEventTypes = <ProgEntryType>{};
      final Set<String?> availableEventPlaces = <String>{};
      for (final ProgEntry entry in event.programmeEntries) {
        availableDates.add(
          DateTime(
            entry.timestamp.year,
            entry.timestamp.month,
            entry.timestamp.day,
          ),
        );
        availableEventTypes.add(entry.type);
        availableEventPlaces.add(entry.placeRef);
      }
      emit(
        ProgrammeLoaded(
          programmeEntries: event.programmeEntries,
          programmeEntriesFiltered: event.programmeEntries,
          myProgrammeEntryIds: _userDataBloc.state.usedData.myProgramme,
          availableDates: availableDates,
          availableEntryTypes: availableEventTypes,
          availableEntryPlaces: availableEventPlaces,
        ),
      );
    } on Exception catch (e) {
      emit(ProgrammeFailState(e.toString()));
    }
  }

  Future<void> _applyAllFilters(event, emit) async {
    try {
      if (state is ProgrammeLoaded) {
        final ProgrammeLoaded lstate = state as ProgrammeLoaded;
        Iterable<ProgEntry> programmeFiltering = lstate.programmeEntries;
        if (lstate.showOnlyMyProgramme) {
          programmeFiltering = programmeFiltering.where(
            (ProgEntry entry) => lstate.myProgrammeEntryIds.contains(entry.id),
          );
        }
        if (lstate.entryTypeFilter.isNotEmpty) {
          programmeFiltering = programmeFiltering
              .where((e) => lstate.entryTypeFilter.contains(e.type));
        }
        if (lstate.entryPlacesFilter.isNotEmpty) {
          programmeFiltering = programmeFiltering
              .where((e) => lstate.entryPlacesFilter.contains(e.placeRef));
        }
        if (lstate.dateFilter.isNotEmpty) {
          programmeFiltering = programmeFiltering.where(
            (e) => lstate.dateFilter.contains(
              DateTime(
                e.timestamp.year,
                e.timestamp.month,
                e.timestamp.day,
              ),
            ),
          );
        }
        if (lstate.queryString.isNotEmpty) {
          programmeFiltering = programmeFiltering.where(
            (e) => e
                .toJson()
                .toString()
                .toLowerCase()
                .contains(lstate.queryString.toLowerCase()),
          );
        }
        emit(
          lstate.copyWith(
            programmeEntriesFiltered: programmeFiltering.toList(),
          ),
        );
      }
    } on Exception catch (e) {
      emit(ProgrammeFailState(e.toString()));
    }
  }

  Future<void> _resetAllFilters(event, emit) async {
    try {
      if (state is ProgrammeLoaded) {
        final ProgrammeLoaded loadedProgramme = state as ProgrammeLoaded;
        emit(
          loadedProgramme.copyWith(
            dateFilter: <DateTime>{},
            entryTypeFilter: <ProgEntryType>{},
            entryPlacesFilter: <String>{},
            queryString: '',
          ),
        );
      }
    } on Exception catch (e) {
      emit(ProgrammeFailState(e.toString()));
    }
  }

  FutureOr<void> _useMyProgrammeFilter(
    UseMyProgrammeFilter event,
    Emitter<ProgrammeState> emit,
  ) {
    emit(
      (state as ProgrammeLoaded).copyWith(
        showOnlyMyProgramme: event.value,
      ),
    );
    add(const ApplyProgrammeFilters());
  }

  Future<void> _updateDateFilter(
    ProgrammeDateFilter event,
    emit,
  ) async {
    if (state is ProgrammeLoaded) {
      final ProgrammeLoaded loadedProgramme = state as ProgrammeLoaded;
      final Set<DateTime> dateFilter = Set.from(loadedProgramme.dateFilter);
      if (dateFilter.contains(event.date)) {
        dateFilter.remove(event.date);
      } else {
        dateFilter.add(event.date);
      }
      emit(
        loadedProgramme.copyWith(
          dateFilter: dateFilter,
        ),
      );
      add(const ApplyProgrammeFilters());
    }
  }

  Future<void> _updateTypeFilter(
    ProgrammeTypeFilter event,
    emit,
  ) async {
    if (state is ProgrammeLoaded) {
      final ProgrammeLoaded loadedProgramme = state as ProgrammeLoaded;
      final Set<ProgEntryType> entryTypeFilter =
          Set.from(loadedProgramme.entryTypeFilter);
      if (entryTypeFilter.contains(event.type)) {
        entryTypeFilter.remove(event.type);
      } else {
        entryTypeFilter.add(event.type);
      }
      emit(
        loadedProgramme.copyWith(
          entryTypeFilter: entryTypeFilter,
        ),
      );
    }
    add(const ApplyProgrammeFilters());
  }

  Future<void> _updatePlaceFilter(
    ProgrammePlaceFilter event,
    emit,
  ) async {
    if (state is ProgrammeLoaded) {
      final ProgrammeLoaded loadedProgramme = state as ProgrammeLoaded;
      final Set<String> entryPlacesFilter =
          Set.from(loadedProgramme.entryPlacesFilter);
      if (entryPlacesFilter.contains(event.placeID)) {
        entryPlacesFilter.remove(event.placeID);
      } else {
        entryPlacesFilter.add(event.placeID);
      }
      emit(
        loadedProgramme.copyWith(
          entryPlacesFilter: entryPlacesFilter,
        ),
      );
    }
    add(const ApplyProgrammeFilters());
  }

  Future<void> _updateTextFilter(
    ProgrammeTextFilter event,
    emit,
  ) async {
    if (state is ProgrammeLoaded) {
      final ProgrammeLoaded loadedProgramme = state as ProgrammeLoaded;
      emit(
        loadedProgramme.copyWith(
          queryString: event.text,
        ),
      );
    }
    add(const ApplyProgrammeFilters());
  }

  @override
  Future<void> close() {
    _programmeEntries.cancel();
    _userDataBlocSubscription.cancel();
    return super.close();
  }
}
