import 'dart:async';

import 'package:blavapp/services/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_sign_in_event.dart';
part 'user_sign_in_state.dart';

class UserSignInBloc extends Bloc<UserSignInEvent, UserSignInState> {
  final AuthRepo _authRepo;
  UserSignInBloc({
    required AuthRepo authRepo,
  })  : _authRepo = authRepo,
        super(const UserSignInState(
          status: SignInStatus.ready,
        )) {
    on<UserSignInEmailChanged>(_userSignInEmailChanged);
    on<UserSignInPswChanged>(_userSignInPswChanged);
    on<UserSignIn>(_userSignIn);
    on<UserSignInGoogle>(_signInGoogle);
    on<UserSignInSoftReset>(_userSignInSoftReset);
  }

  FutureOr<void> _userSignInEmailChanged(
    UserSignInEmailChanged event,
    Emitter<UserSignInState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  FutureOr<void> _userSignInPswChanged(
    UserSignInPswChanged event,
    Emitter<UserSignInState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  Future<FutureOr<void>> _userSignIn(
    UserSignIn event,
    Emitter<UserSignInState> emit,
  ) async {
    if (state.status == SignInStatus.ready) {
      emit(state.copyWith(status: SignInStatus.loading));
      // Form validation
      final bool isEmailValid =
          state.email.contains('@') && state.email.contains('.');
      RegExp regexPsw =
          RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');
      final bool isPswValid = regexPsw.hasMatch(state.password);
      final bool isFormValid = isEmailValid && isPswValid;
      if (isFormValid) {
        emit(
          state.copyWith(
            status: SignInStatus.loading,
            isFormValid: isFormValid,
            isEmailValid: isEmailValid,
            isPasswordValid: isPswValid,
          ),
        );
        try {
          await _authRepo.signInEmailAndPassword(state.email, state.password);
          emit(
            state.copyWith(
              status: SignInStatus.success,
            ),
          );
        } catch (e) {
          emit(
            state.copyWith(
              status: SignInStatus.fail,
              message: e.toString(),
            ),
          );
          Future.delayed(const Duration(seconds: 1), () {
            add(const UserSignInSoftReset());
          });
        }
      } else {
        emit(
          state.copyWith(
            status: SignInStatus.ready,
            isFormValid: isFormValid,
            isEmailValid: isEmailValid,
            isPasswordValid: isPswValid,
          ),
        );
      }
    }
  }

  FutureOr<void> _signInGoogle(
    UserSignInGoogle event,
    Emitter<UserSignInState> emit,
  ) {}

  FutureOr<void> _userSignInSoftReset(
    UserSignInSoftReset event,
    Emitter<UserSignInState> emit,
  ) {
    emit(state.copyWith(
      status: SignInStatus.ready,
    ));
  }
}
