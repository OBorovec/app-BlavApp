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
  }) : super(UserProgrammeAgendaState(
          programmeEntries: programmeBloc.state.programmeEntries,
          myProgrammeEntryIds: userDataBloc.state.userData.myProgramme,
          event: event,
          agendaData: programmeBloc.state.programmeEntries
              .where(
                (ProgrammeEntry entry) =>
                    userDataBloc.state.userData.myProgramme.contains(entry.id),
              )
              .toList(),
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
    // Event listeners
    on<UpdateProgrammeEntries>(_updateProgrammeEntries);
    on<UpdateMyProgrammeEntryIds>(_updateMyProgrammeEntryIds);
    on<UpdateAgendaData>(_updateAgendaData);
    // Init
    add(const UpdateAgendaData());
  }

  FutureOr<void> _updateProgrammeEntries(
    UpdateProgrammeEntries event,
    Emitter<UserProgrammeAgendaState> emit,
  ) {
    emit(
      state.copyWith(
        programmeEntries: event.programmeEntries,
      ),
    );
    add(const UpdateAgendaData());
  }

  FutureOr<void> _updateMyProgrammeEntryIds(
    UpdateMyProgrammeEntryIds event,
    Emitter<UserProgrammeAgendaState> emit,
  ) {
    emit(
      state.copyWith(
        myProgrammeEntryIds: event.myProgrammeEntryIds,
      ),
    );
    add(const UpdateAgendaData());
  }

  FutureOr<void> _updateAgendaData(
    UpdateAgendaData event,
    Emitter<UserProgrammeAgendaState> emit,
  ) {
    emit(state.copyWith(
      agendaData: state.programmeEntries
          .where(
            (ProgrammeEntry entry) =>
                state.myProgrammeEntryIds.contains(entry.id),
          )
          .toList(),
    ));
  }

  @override
  Future<void> close() {
    _programmeBlocSubscription.cancel();
    _userDataBlocSubscription.cancel();
    return super.close();
  }
}
