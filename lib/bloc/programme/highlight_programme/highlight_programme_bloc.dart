import 'dart:async';

import 'package:blavapp/bloc/programme/data_programme/programme_bloc.dart';
import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/model/programme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'highlight_programme_event.dart';
part 'highlight_programme_state.dart';

class HighlightProgrammeBloc
    extends Bloc<HighlightProgrammeEvent, HighlightProgrammeState> {
  late final StreamSubscription<ProgrammeState> _programmeBlocSubscription;
  late final StreamSubscription<UserDataState> _userDataBlocSubscription;
  HighlightProgrammeBloc({
    required ProgrammeBloc programmeBloc,
    required UserDataBloc userDataBloc,
  }) : super(HighlightProgrammeState(
          programmeEntries: programmeBloc.state.programmeEntries,
          myProgrammeEntryIds: userDataBloc.state.userData.myProgramme,
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
          myProgrammeEntryIds: state.userData.myProgramme,
        ),
      ),
    );
    on<UpdateProgrammeEntries>(_updateProgrammeEntries);
    on<UpdateMyProgrammeEntryIds>(_updateMyProgrammeEntryIds);
    on<UpdateViewData>(_updateViewData);
    // Initialise view data
    add(const UpdateViewData());
  }

  FutureOr<void> _updateProgrammeEntries(
    UpdateProgrammeEntries event,
    Emitter<HighlightProgrammeState> emit,
  ) {
    emit(state.copyWith(
      programmeEntries: event.programmeEntries,
    ));
    add(const UpdateViewData());
  }

  FutureOr<void> _updateMyProgrammeEntryIds(
    UpdateMyProgrammeEntryIds event,
    Emitter<HighlightProgrammeState> emit,
  ) {
    emit(state.copyWith(
      myProgrammeEntryIds: event.myProgrammeEntryIds,
    ));
    add(const UpdateViewData());
  }

  FutureOr<void> _updateViewData(
    UpdateViewData event,
    Emitter<HighlightProgrammeState> emit,
  ) {
    final DateTime now = DateTime.now();
    // Filter ongoing programme entries
    final List<ProgEntry> ongoingEntries =
        state.programmeEntries.where((ProgEntry entry) {
      final DateTime start = entry.timestamp;
      final DateTime end = start.add(Duration(minutes: entry.duration));
      return start.isBefore(now) && end.isAfter(now);
    }).toList();
    // Filter upcoming programme entries
    final List<ProgEntry> allTodayUpcomingEntries =
        state.programmeEntries.where((ProgEntry entry) {
      // Date time tomorrow 6 am
      final DateTime endLimit = DateTime(
        now.year,
        now.month,
        now.day + 1,
        6,
      );
      return entry.timestamp.isBefore(endLimit);
    }).where((ProgEntry entry) {
      return entry.timestamp.isAfter(now);
    }).toList();
    allTodayUpcomingEntries.sort(
      ((a, b) => a.timestamp.compareTo(b.timestamp)),
    );
    final List<ProgEntry> upcomingEntries =
        allTodayUpcomingEntries.take(6).toList();
    // Filter upcoming programme entries for my programme entries
    final List<ProgEntry> allUpcomingMyEntries = state.programmeEntries
        .where(
          (ProgEntry entry) => state.myProgrammeEntryIds.contains(entry.id),
        )
        .where(
          (ProgEntry entry) => entry.timestamp.isAfter(now),
        )
        .take(6)
        .toList();
    allUpcomingMyEntries.sort(
      ((a, b) => a.timestamp.compareTo(b.timestamp)),
    );
    final List<ProgEntry> upcomingMyEntries =
        allUpcomingMyEntries.take(6).toList();
    // Emit results
    emit(state.copyWith(
      ongoingEntries: ongoingEntries,
      upcomingEntries: upcomingEntries,
      upcomingMyEntries: upcomingMyEntries,
    ));
  }

  @override
  Future<void> close() {
    _programmeBlocSubscription.cancel();
    _userDataBlocSubscription.cancel();
    return super.close();
  }
}
