part of 'user_perms_bloc.dart';

abstract class UserPermsEvent extends Equatable {
  const UserPermsEvent();

  @override
  List<Object> get props => [];
}

class EmptyUserPerms extends UserPermsEvent {}

class LoadUserPerms extends UserPermsEvent {
  final String uid;

  const LoadUserPerms({
    required this.uid,
  });

  @override
  List<Object> get props => [uid];
}

class ToggleDevMode extends UserPermsEvent {
  const ToggleDevMode();
}
