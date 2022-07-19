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
        super(authRepo.isSignedIn()
            ? AuthState(
                status: AuthStatus.authenticated,
                user: authRepo.getCurrentUser()!)
            : const AuthState(
                status: AuthStatus.unauthenticated,
                user: null,
              )) {
    _userSubscription = _authRepo.user.listen(_onUserChanged);
    on<UserActive>(_userActive);
    on<UserInactive>(_userInactive);
    on<UserAuthDelete>(_userDelete);
    on<UserAuthSignOut>(_userSignOut);
  }

  // Data listeners
  void _onUserChanged(User? user) {
    if (user != null) {
      add(UserActive(user, null));
    } else {
      add(UserInactive());
    }
  }

  // Event functions
  Future<void> _userActive(UserActive event, emit) async {
    emit(
      AuthState(
        status: AuthStatus.authenticated,
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
        status: AuthStatus.unauthenticated,
        user: null,
      ),
    );
  }

  FutureOr<void> _userDelete(
    UserAuthDelete event,
    Emitter<AuthState> emit,
  ) {
    // TODO: Delete user's data
    // TODO: Delete user's profile picture
    _authRepo.deleteUser();
  }

  FutureOr<void> _userSignOut(
    UserAuthSignOut event,
    Emitter<AuthState> emit,
  ) {
    _authRepo.signOut();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
