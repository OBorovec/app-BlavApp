import 'package:blavapp/services/auth_repo.dart';
import 'package:blavapp/services/storage_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:async';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final User _user;
  final AuthRepo _authRepo;
  final StorageRepo _storageRepo;
  UserProfileBloc({
    required User user,
    required AuthRepo authRepo,
    required StorageRepo storageRepo,
  })  : _user = user,
        _authRepo = authRepo,
        _storageRepo = storageRepo,
        super(UserProfileState(
          user: user,
          nickname: user.displayName ?? '',
        )) {
    on<UserEmailVerification>(_userEmailVerification);
    on<UserEditNicknameToggle>(_userEditNicknameToggle);
    on<UserNicknameOnChange>(_userNicknameOnChange);
    on<UserEditPicture>(_userEditPicture);
    on<UserEditPictureTake>(_userEditPictureTake);
    on<UserEditPictureLoad>(_userEditPictureLoad);
    on<UserProfileRefresh>(_userProfileRefresh);
    on<UserPasswordReset>(_userPasswordReset);
  }

  Future<FutureOr<void>> _userEmailVerification(
    UserEmailVerification event,
    Emitter<UserProfileState> emit,
  ) async {
    if (_user.emailVerified) {
      emit(
        state.copyWith(status: UserEditStatus.emailVerificationVerified),
      );
    } else {
      try {
        await _user.sendEmailVerification();
        emit(
          state.copyWith(status: UserEditStatus.emailVerificationSent),
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: UserEditStatus.emailVerificationFailed,
            errorMessage: e.toString(),
          ),
        );
      }
    }
  }

  FutureOr<void> _userEditNicknameToggle(
    UserEditNicknameToggle event,
    Emitter<UserProfileState> emit,
  ) {
    if (state.editingNickname) {
      _user.updateDisplayName(state.nickname);
    }
    emit(state.copyWith(editingNickname: !state.editingNickname));
  }

  FutureOr<void> _userNicknameOnChange(
    UserNicknameOnChange event,
    Emitter<UserProfileState> emit,
  ) {
    emit(state.copyWith(nickname: event.nickname));
  }

  FutureOr<void> _userEditPicture(
    UserEditPicture event,
    Emitter<UserProfileState> emit,
  ) {}

  FutureOr<void> _userEditPictureTake(
    UserEditPictureTake event,
    Emitter<UserProfileState> emit,
  ) {}

  FutureOr<void> _userEditPictureLoad(
    UserEditPictureLoad event,
    Emitter<UserProfileState> emit,
  ) {}

  FutureOr<void> _userProfileRefresh(
    UserProfileRefresh event,
    Emitter<UserProfileState> emit,
  ) {
    _user.reload();
  }

  FutureOr<void> _userPasswordReset(
    UserPasswordReset event,
    Emitter<UserProfileState> emit,
  ) {
    try {
      _authRepo.sendPasswordResetEmail(_user.email!);
      emit(
        state.copyWith(status: UserEditStatus.passwordEmailSent),
      );
    } catch (e) {
      emit(state.copyWith(
        status: UserEditStatus.passwordEmailFailedSent,
        errorMessage: e.toString(),
      ));
    }
  }
}
