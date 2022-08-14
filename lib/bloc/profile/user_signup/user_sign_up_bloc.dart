import 'dart:async';

import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/model/user_data.dart';
import 'package:blavapp/services/auth_repo.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'user_sign_up_event.dart';
part 'user_sign_up_state.dart';

class UserSignUpBloc extends Bloc<UserSignUpEvent, UserSignUpState> {
  final AuthRepo _authRepo;
  final DataRepo _dataRepo;
  final UserDataBloc _userDataBloc;
  UserSignUpBloc({
    required AuthRepo authRepo,
    required DataRepo dataRepo,
    required UserDataBloc userDataBloc,
  })  : _authRepo = authRepo,
        _dataRepo = dataRepo,
        _userDataBloc = userDataBloc,
        super(const UserSignUpState()) {
    on<UserSignUpEmailChanged>(_userEmailChanged);
    on<UserSignUpPswChanged>(_userPasswordChanged);
    on<UserSignUpNNChanged>(_userNickNameChanged);
    on<UserSignUp>(_userFormValidate);
    on<UserSignUpGoogle>(_userGoogleSignUp);
  }

  FutureOr<void> _userEmailChanged(
    UserSignUpEmailChanged event,
    Emitter<UserSignUpState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  FutureOr<void> _userPasswordChanged(
    UserSignUpPswChanged event,
    Emitter<UserSignUpState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  FutureOr<void> _userNickNameChanged(
    UserSignUpNNChanged event,
    Emitter<UserSignUpState> emit,
  ) {
    emit(state.copyWith(nickName: event.nickName));
  }

  Future<FutureOr<void>> _userFormValidate(
    UserSignUp event,
    Emitter<UserSignUpState> emit,
  ) async {
    if (state.status == SignUpStatus.ready) {
      emit(state.copyWith(status: SignUpStatus.loading));
      // Form validation
      final bool isEmailValid =
          state.email.contains('@') && state.email.contains('.');
      RegExp regexPsw =
          RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');
      final bool isPswValid = regexPsw.hasMatch(state.password);
      RegExp regexNick = RegExp(r'^[A-Za-z0-9_-]*$');
      final bool isNickValid =
          regexNick.hasMatch(state.nickName) && state.nickName.length > 6;
      final bool isFormValid = isEmailValid && isPswValid && isNickValid;
      if (isFormValid) {
        emit(
          state.copyWith(
            status: SignUpStatus.loading,
            isFormValid: isFormValid,
            isEmailValid: isEmailValid,
            isPasswordValid: isPswValid,
            isNickNameValid: isNickValid,
          ),
        );
        try {
          final User user = await _authRepo.signUpUserWithEmailPass(
            state.email,
            state.password,
          );
          await user.updateDisplayName(state.nickName);
          await user.reload();
          _userDataBloc.add(InitUserData(user: user));
          emit(
            state.copyWith(
              status: SignUpStatus.success,
            ),
          );
          _dataRepo.initUserData(user.uid, const UserData());
        } catch (e) {
          emit(
            state.copyWith(
              status: SignUpStatus.fail,
              message: e.toString(),
            ),
          );
          Future.delayed(const Duration(seconds: 5), () {});
          emit(
            state.copyWith(
              status: SignUpStatus.ready,
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            status: SignUpStatus.ready,
            isFormValid: isFormValid,
            isEmailValid: isEmailValid,
            isPasswordValid: isPswValid,
            isNickNameValid: isNickValid,
          ),
        );
      }
    }
  }

  FutureOr<void> _userGoogleSignUp(
    UserSignUpGoogle event,
    Emitter<UserSignUpState> emit,
  ) {}

  @override
  Future<void> close() {
    return super.close();
  }
}
