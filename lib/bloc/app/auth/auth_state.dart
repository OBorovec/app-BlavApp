part of 'auth_bloc.dart';

enum AuthStatus { init, auth, unauth }

class AuthState extends Equatable {
  final AuthStatus status;
  final User? user;

  const AuthState({
    this.status = AuthStatus.init,
    this.user,
  });

  @override
  List<Object> get props => [status, user ?? ''];
}
