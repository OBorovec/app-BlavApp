import 'dart:async';

import 'package:blavapp/services/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_delete_event.dart';
part 'user_delete_state.dart';

class UserDeleteBloc extends Bloc<UserDeleteEvent, UserDeleteState> {
  final AuthRepo _authRepo;
  UserDeleteBloc({
    required AuthRepo authRepo,
  })  : _authRepo = authRepo,
        super(const UserDeleteState()) {
    on<UserDeletePswChanged>(_userDeletePswChanged);
    on<UserDelete>(_userDelete);
  }

  FutureOr<void> _userDeletePswChanged(
    UserDeletePswChanged event,
    Emitter<UserDeleteState> emit,
  ) {
    emit(state.copyWith(
      password: event.password,
    ));
  }

  Future<FutureOr<void>> _userDelete(
    UserDelete event,
    Emitter<UserDeleteState> emit,
  ) async {
    if (state.status == UserDeleteStatus.ready) {
      RegExp regexPsw =
          RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');
      final bool isPswValid = regexPsw.hasMatch(state.password);
      if (isPswValid) {
        emit(
          state.copyWith(
            status: UserDeleteStatus.loading,
            isPasswordValid: isPswValid,
          ),
        );
        try {
          await _authRepo.deleteUser(state.password);
          emit(
            state.copyWith(
              status: UserDeleteStatus.success,
            ),
          );
        } catch (e) {
          emit(
            state.copyWith(
              status: UserDeleteStatus.fail,
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            status: UserDeleteStatus.ready,
            isPasswordValid: isPswValid,
          ),
        );
      }
    }
  }
}
