import 'dart:async';

import 'package:blavapp/bloc/programme/data_programme/programme_bloc.dart';
import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/model/event.dart';
import 'package:blavapp/model/programme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_programme_agenda_event.dart';
part 'user_programme_agenda_state.dart';

class UserProgrammeAgendaBloc
    extends Bloc<UserProgrammeAgendaEvent, UserProgrammeAgendaState> {
  late final StreamSubscription<ProgrammeState> _programmeBlocSubscription;
  late final StreamSubscription<UserDataState> _userDataBlocSubscription;

  UserProgrammeAgendaBloc({
    required ProgrammeBloc programmeBloc,
    required UserDataBloc userDataBloc,
    required Event event,
  }) : super(_updateState(
          entries: programmeBloc.state.programmeEntries,
          myEntryIds: userDataBloc.state.userData.myProgramme,
          event: event,
        )) {
    _programmeBlocSubscription = programmeBloc.stream.listen(
      (ProgrammeState state) {
        add(
          UpdateProgrammeEntries(programmeEntries: state.programmeEntries),
        );
      },
    );
    _userDataBlocSubscription = userDataBloc.stream.listen(
      (UserDataState state) => add(
        UpdateMyProgrammeEntryIds(
            myProgrammeEntryIds: state.userData.myProgramme),
      ),
    );
    // Event listeners
    on<UpdateProgrammeEntries>(_updateProgrammeEntries);
    on<UpdateMyProgrammeEntryIds>(_updateMyProgrammeEntryIds);
    on<UserAgendaScopeDate>(_userAgendaScopeDate);
    on<UserAgendaResetView>(_userAgendaResetView);
    on<UserAgendaShowAllToggle>(_userAgendaShowAllToggle);
  }

  static UserProgrammeAgendaState _updateState({
    UserProgrammeAgendaState? state,
    List<ProgrammeEntry>? entries,
    final Set<String>? myEntryIds,
    final Event? event,
  }) {
    state ??= UserProgrammeAgendaState(
      programmeEntries: entries!,
      myProgrammeEntryIds: myEntryIds!,
      event: event!,
    );
    // Data
    late final List<AgendaData> agendaData;
    if (state.showAll) {
      agendaData = state.programmeEntries
          .map((e) => AgendaData(
                entry: e,
                colored: state?.myProgrammeEntryIds.contains(e.id) ?? false,
              ))
          .toList();
    } else {
      agendaData = state.programmeEntries
          .where((ProgrammeEntry entry) =>
              state?.myProgrammeEntryIds.contains(entry.id) ?? false)
          .map((e) => AgendaData(
                entry: e,
                colored: true,
              ))
          .toList();
    }
    // SfCalendar view variables
    late final DateTime minDate;
    late final DateTime maxDate;
    late final double minHour;
    late final double maxHour;
    late final int dayCount;
    late final List<int> nonEventDays;
    if (state.singleDayMod && state.singleDay != null) {
      minDate = state.singleDay!;
      maxDate = state.singleDay!.add(const Duration(hours: 23));
      final Set<int> allDays = List<int>.generate(7, (i) => i).toSet();
      dayCount = 1;
      nonEventDays = allDays.difference({minDate.weekday % 7}).toList();
    } else {
      minDate = state.event.dayStart;
      maxDate = state.event.dayEnd;
      final Set<int> allDays = List<int>.generate(7, (i) => i).toSet();
      dayCount = maxDate.difference(minDate).inDays + 1;
      final Set<int> eventDays = List<int>.generate(
        dayCount,
        (i) => (minDate.weekday + i) % 7,
      ).toSet();
      nonEventDays = allDays.difference(eventDays).toList();
    }
    final List<ProgrammeEntry> entriesInScope =
        state.singleDayMod && state.singleDay != null
            ? state.programmeEntries
                .where((e) => e.timestamp.day == state?.singleDay!.day)
                .toList()
            : state.programmeEntries;

    minHour = entriesInScope
        .map((e) => e.timestamp.hour)
        .reduce(
          (value, element) => value < element ? value : element,
        )
        .toDouble();
    maxHour = entriesInScope
        .map((e) => e.timestamp.hour + e.duration / 60)
        .reduce(
          (value, element) => value > element ? value : element,
        )
        .ceil()
        .toDouble();
    return state.copyWith(
      minDate: minDate,
      maxDate: maxDate,
      minHour: minHour,
      maxHour: maxHour,
      dayCount: dayCount,
      nonEventDays: nonEventDays,
      agendaData: agendaData,
    );
  }

  @override
  Future<void> close() {
    _programmeBlocSubscription.cancel();
    _userDataBlocSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _updateProgrammeEntries(
    UpdateProgrammeEntries event,
    Emitter<UserProgrammeAgendaState> emit,
  ) {
    emit(
      _updateState(
          state: state.copyWith(
        programmeEntries: event.programmeEntries,
      )),
    );
  }

  FutureOr<void> _updateMyProgrammeEntryIds(
    UpdateMyProgrammeEntryIds event,
    Emitter<UserProgrammeAgendaState> emit,
  ) {
    emit(
      _updateState(
          state: state.copyWith(
        myProgrammeEntryIds: event.myProgrammeEntryIds,
      )),
    );
  }

  FutureOr<void> _userAgendaScopeDate(
    UserAgendaScopeDate event,
    Emitter<UserProgrammeAgendaState> emit,
  ) {
    emit(
      _updateState(
          state: state.copyWith(
        singleDayMod: true,
        singleDay: event.date,
      )),
    );
  }

  FutureOr<void> _userAgendaResetView(
    UserAgendaResetView event,
    Emitter<UserProgrammeAgendaState> emit,
  ) {
    emit(
      _updateState(
          state: state.copyWith(
        singleDayMod: false,
        singleDay: null,
        showAll: false,
      )),
    );
  }

  FutureOr<void> _userAgendaShowAllToggle(
    UserAgendaShowAllToggle event,
    Emitter<UserProgrammeAgendaState> emit,
  ) {
    emit(
      _updateState(
          state: state.copyWith(
        showAll: !state.showAll,
      )),
    );
  }
}
