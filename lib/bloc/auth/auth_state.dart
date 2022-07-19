part of 'auth_bloc.dart';

enum AuthStatus { authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus status;
  final User? user;

  const AuthState({
    required this.status,
    required this.user,
  });

  @override
  List<Object> get props => [status, user ?? ''];
}
