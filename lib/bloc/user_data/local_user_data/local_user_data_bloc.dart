import 'dart:async';

import 'package:blavapp/model/user_data_local.dart';
import 'package:blavapp/services/prefs_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'local_user_data_event.dart';
part 'local_user_data_state.dart';

class LocalUserDataBloc extends Bloc<LocalUserDataEvent, LocalUserDataState> {
  final PrefsRepo _prefs;
  LocalUserDataBloc({
    required PrefsRepo prefs,
  })  : _prefs = prefs,
        super(
          const LocalUserDataState(
            userDataLocal: UserDataLocal(),
          ),
        ) {
    on<LocalUserDataInit>(_initLocalUserData);
    on<HideBoardNote>(_hideBoardNote);
    on<ResetBoardNotes>(_resetBoardNotes);
    // Init
    add(const LocalUserDataInit());
  }

  FutureOr<void> _initLocalUserData(
    LocalUserDataInit event,
    Emitter<LocalUserDataState> emit,
  ) {
    final UserDataLocal? userDataLocal = _prefs.loadUserDataLocal();
    if (userDataLocal != null) {
      emit(
        LocalUserDataState(userDataLocal: userDataLocal),
      );
    }
  }

  FutureOr<void> _hideBoardNote(
    HideBoardNote event,
    Emitter<LocalUserDataState> emit,
  ) {
    Set<String> hiddenBoardNotes = {event.noteId};
    hiddenBoardNotes.addAll(state.userDataLocal.hiddenBoardNotes);
    final UserDataLocal userDataLocal = state.userDataLocal.copyWith(
      hiddenBoardNotes: hiddenBoardNotes,
    );
    _prefs.saveUserDataLocal(userDataLocal);
    emit(
      LocalUserDataState(userDataLocal: userDataLocal),
    );
  }

  FutureOr<void> _resetBoardNotes(
    ResetBoardNotes event,
    Emitter<LocalUserDataState> emit,
  ) {
    final UserDataLocal userDataLocal = state.userDataLocal.copyWith(
      hiddenBoardNotes: const {},
    );
    _prefs.saveUserDataLocal(userDataLocal);
    emit(
      LocalUserDataState(
        userDataLocal: userDataLocal,
      ),
    );
  }
}
