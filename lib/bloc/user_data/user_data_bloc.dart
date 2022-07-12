import 'package:blavapp/bloc/auth/auth_bloc.dart';
import 'package:blavapp/model/user_data.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  final AuthBloc authBloc;
  late final StreamSubscription _authBlocSub;

  UserDataBloc({
    required this.authBloc,
  }) : super(UserDataState(usedData: UserData())) {
    _authBlocSub = authBloc.stream.listen(_onAuthBlocChange);
    on<EmptyUserData>(_emptyUserData);
    on<InitUserData>(_initUserData);
    on<LoadUserData>(_loadUserData);
    on<ProgEntryToggleUserData>(_progEntryToggleUserData);
    on<ProgNotificationToggleUserData>(_progNotificationToggleUserData);
  }

  void _onAuthBlocChange(AuthState state) {
    if (state is UserAuthenticated) {
      add(
        LoadUserData(
          uid: state.user.uid,
        ),
      );
    } else {
      add(EmptyUserData());
    }
  }

  FutureOr<void> _emptyUserData(
    EmptyUserData event,
    Emitter<UserDataState> emit,
  ) {
    emit(UserDataState(usedData: UserData()));
  }

  FutureOr<void> _initUserData(
    InitUserData event,
    Emitter<UserDataState> emit,
  ) {}

  FutureOr<void> _loadUserData(
    LoadUserData event,
    Emitter<UserDataState> emit,
  ) {}

  FutureOr<void> _progEntryToggleUserData(
    ProgEntryToggleUserData event,
    Emitter<UserDataState> emit,
  ) {}

  FutureOr<void> _progNotificationToggleUserData(
    ProgNotificationToggleUserData event,
    Emitter<UserDataState> emit,
  ) {}

  @override
  Future<void> close() {
    _authBlocSub.cancel();
    return super.close();
  }
}
