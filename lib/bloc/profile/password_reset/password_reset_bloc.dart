import 'dart:async';

import 'package:blavapp/services/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'password_reset_event.dart';
part 'password_reset_state.dart';

class PasswordResetBloc extends Bloc<PasswordResetEvent, PasswordResetState> {
  final AuthRepo _authRepo;
  PasswordResetBloc({
    required AuthRepo authRepo,
  })  : _authRepo = authRepo,
        super(PasswordResetState()) {
    on<PasswordResetEmailChanged>(_userResetEmailChanged);
    on<PasswordReset>(_userReset);
  }

  FutureOr<void> _userResetEmailChanged(
    PasswordResetEmailChanged event,
    Emitter<PasswordResetState> emit,
  ) {
    emit(state.copyWith(
      email: event.email,
    ));
  }

  FutureOr<void> _userReset(
    PasswordReset event,
    Emitter<PasswordResetState> emit,
  ) {
    if (state.status == PasswordResetStatus.ready) {
      RegExp regexEmail = RegExp(
          r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
      final bool isEmailValid = regexEmail.hasMatch(state.email);
      if (isEmailValid) {
        emit(
          state.copyWith(
            status: PasswordResetStatus.loading,
            isValid: isEmailValid,
          ),
        );
        try {
          _authRepo.sendPasswordResetEmail(state.email);
          emit(
            state.copyWith(
              status: PasswordResetStatus.success,
            ),
          );
        } catch (e) {
          emit(
            state.copyWith(
              status: PasswordResetStatus.fail,
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            isValid: isEmailValid,
          ),
        );
      }
    }
  }
}
