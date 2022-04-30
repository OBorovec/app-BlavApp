part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class UserAuthenticated extends AuthState {
  final User user;

  const UserAuthenticated({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

class UserNotAuthenticated extends AuthState {}
