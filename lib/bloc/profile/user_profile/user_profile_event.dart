part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class UserEmailVerification extends UserProfileEvent {
  const UserEmailVerification();
}

class UserProfileRefresh extends UserProfileEvent {
  const UserProfileRefresh();
}

class UserPasswordReset extends UserProfileEvent {
  const UserPasswordReset();
}

class UserEditNicknameToggle extends UserProfileEvent {
  final BuildContext context;
  const UserEditNicknameToggle({required this.context});
}

class UserNicknameOnChange extends UserProfileEvent {
  final String nickname;

  const UserNicknameOnChange({
    required this.nickname,
  });

  @override
  List<Object> get props => [nickname];
}

class UserEditNicknameReset extends UserProfileEvent {
  const UserEditNicknameReset();
}

class UserEditPictureTake extends UserProfileEvent {
  const UserEditPictureTake();
}

class UserEditPictureLoad extends UserProfileEvent {
  const UserEditPictureLoad();
}

class UserSignOut extends UserProfileEvent {
  const UserSignOut();
}

class UserProfileDelete extends UserProfileEvent {
  const UserProfileDelete();
}
