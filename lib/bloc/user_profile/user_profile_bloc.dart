import 'package:blavapp/bloc/auth/auth_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:async';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final AuthBloc authBloc;
  late final StreamSubscription _authBlocSub;

  UserProfileBloc({
    required this.authBloc,
  }) : super(NoUser()) {
    _authBlocSub = authBloc.stream.listen(_onAuthBlocChange);
    on<EmptyUser>(_emptyUser);
    on<SetUser>(_setUser);
  }

  void _onAuthBlocChange(AuthState event) {
    if (event is UserAuthenticated) {
      add(
        SetUser(
          user: event.user,
        ),
      );
    } else {
      add(EmptyUser());
    }
  }

  FutureOr<void> _emptyUser(
    EmptyUser event,
    Emitter<UserProfileState> emit,
  ) {
    emit(
      NoUser(),
    );
  }

  FutureOr<void> _setUser(
    SetUser event,
    Emitter<UserProfileState> emit,
  ) {
    emit(
      ActiveUser(
        user: event.user,
      ),
    );
  }

  @override
  Future<void> close() {
    _authBlocSub.cancel();
    return super.close();
  }
}
