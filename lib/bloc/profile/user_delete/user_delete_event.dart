part of 'user_delete_bloc.dart';

abstract class UserDeleteEvent extends Equatable {
  const UserDeleteEvent();

  @override
  List<Object> get props => [];
}

class UserDeletePswChanged extends UserDeleteEvent {
  final String password;
  const UserDeletePswChanged({
    required this.password,
  });
}

class UserDelete extends UserDeleteEvent {
  const UserDelete();
}
