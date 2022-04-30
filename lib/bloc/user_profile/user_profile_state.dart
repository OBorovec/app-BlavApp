part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

class NoUser extends UserProfileState {}

class ActiveUser extends UserProfileState {
  final User user;

  const ActiveUser({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}
