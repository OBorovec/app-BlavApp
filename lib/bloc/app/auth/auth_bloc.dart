import 'dart:async';

import 'package:blavapp/model/user_data.dart';
import 'package:blavapp/services/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<UserEvent, AuthState> {
  final AuthRepo _authRepo;
  late final StreamSubscription<User?> _userSubscription;

  AuthBloc({
    required AuthRepo authRepo,
  })  : _authRepo = authRepo,
        super(const AuthState()) {
    _userSubscription = _authRepo.user.listen(_onUserChanged);
    on<UserActive>(_userActive);
    on<UserInactive>(_userInactive);
    on<LoadUser>(_loadUser);
    // Init
    // add(const LoadUser());
  }

  // Data listeners
  void _onUserChanged(User? user) {
    if (user != null) {
      add(UserActive(user, null));
    } else {
      add(const UserInactive());
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  // Event functions
  Future<void> _userActive(UserActive event, emit) async {
    emit(
      AuthState(
        status: AuthStatus.auth,
        user: event.user,
      ),
    );
  }

  FutureOr<void> _userInactive(
    UserInactive event,
    Emitter<AuthState> emit,
  ) {
    emit(
      const AuthState(
        status: AuthStatus.unauth,
        user: null,
      ),
    );
  }

  FutureOr<void> _loadUser(
    LoadUser event,
    Emitter<AuthState> emit,
  ) {
    if (_authRepo.isSignedIn()) {
      emit(AuthState(
        status: AuthStatus.auth,
        user: _authRepo.getCurrentUser()!,
      ));
    } else {
      emit(const AuthState(
        status: AuthStatus.unauth,
        user: null,
      ));
    }
  }
}
