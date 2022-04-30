part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class EmptyUser extends UserProfileEvent {}

class SetUser extends UserProfileEvent {
  final User user;

  const SetUser({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}
