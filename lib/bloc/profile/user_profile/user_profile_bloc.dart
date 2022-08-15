import 'dart:io';

import 'package:blavapp/services/auth_repo.dart';
import 'package:blavapp/services/storage_repo.dart';
import 'package:blavapp/utils/command_center.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
          nickname: '',
        )) {
    // Event listeners
    on<UserEmailVerification>(_userEmailVerification);
    on<UserEditNicknameToggle>(_userEditNicknameToggle);
    on<UserNicknameOnChange>(_userNicknameOnChange);
    on<UserEditNicknameReset>(_userEditNicknameReset);
    on<UserEditPictureTake>(_userEditPictureTake);
    on<UserEditPictureLoad>(_userEditPictureLoad);
    on<UserProfileRefresh>(_userProfileRefresh);
    on<UserPasswordReset>(_userPasswordReset);
    // Init events
    add(const UserEditNicknameReset());
  }

  Future<FutureOr<void>> _userEmailVerification(
    UserEmailVerification event,
    Emitter<UserProfileState> emit,
  ) async {
    if (_user.emailVerified) {
      emit(
        state.copyWith(
            notification: UserProfileNotification.emailVerificationVerified),
      );
    } else {
      try {
        await _user.sendEmailVerification();
        emit(
          state.copyWith(
              notification: UserProfileNotification.emailVerificationSent),
        );
      } catch (e) {
        emit(
          state.copyWith(
            notification: UserProfileNotification.emailVerificationFailed,
            message: e.toString(),
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
      if (state.nickname.startsWith('!')) {
        cmd(state.nickname, event.context);
        add(const UserEditNicknameReset());
      } else {
        _user.updateDisplayName(state.nickname);
      }
    }
    emit(state.copyWith(editingNickname: !state.editingNickname));
  }

  FutureOr<void> _userNicknameOnChange(
    UserNicknameOnChange event,
    Emitter<UserProfileState> emit,
  ) {
    emit(state.copyWith(nickname: event.nickname));
  }

  FutureOr<void> _userEditNicknameReset(
    UserEditNicknameReset event,
    Emitter<UserProfileState> emit,
  ) {
    emit(state.copyWith(nickname: _user.displayName));
  }

  Future<FutureOr<void>> _userEditPictureTake(
    UserEditPictureTake event,
    Emitter<UserProfileState> emit,
  ) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      _setUserPhoto(photo);
    }
  }

  Future<FutureOr<void>> _userEditPictureLoad(
    UserEditPictureLoad event,
    Emitter<UserProfileState> emit,
  ) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _setUserPhoto(image);
    }
  }

  Future<void> _setUserPhoto(XFile image) async {
    final String photoStorageURL =
        await _storageRepo.uploadFile(_user.uid, File(image.path));
    _user.updatePhotoURL(photoStorageURL);
    _user.reload();
  }

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
        state.copyWith(notification: UserProfileNotification.passwordEmailSent),
      );
    } catch (e) {
      emit(state.copyWith(
        notification: UserProfileNotification.passwordEmailFailedSent,
        message: e.toString(),
      ));
    }
  }
}
