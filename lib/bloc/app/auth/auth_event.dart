part of 'auth_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserInactive extends UserEvent {
  const UserInactive();
}

class UserActive extends UserEvent {
  final User user;
  final UserData? userData;

  const UserActive(this.user, this.userData);

  @override
  List<Object> get props => [user.uid];
}

class LoadUser extends UserEvent {
  const LoadUser();
}
