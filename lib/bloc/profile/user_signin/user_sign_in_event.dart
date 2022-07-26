part of 'user_sign_in_bloc.dart';

abstract class UserSignInEvent extends Equatable {
  const UserSignInEvent();

  @override
  List<Object> get props => [];
}

class UserSignInEmailChanged extends UserSignInEvent {
  final String email;
  const UserSignInEmailChanged({
    required this.email,
  });
}

class UserSignInPswChanged extends UserSignInEvent {
  final String password;
  const UserSignInPswChanged({
    required this.password,
  });
}

class UserSignIn extends UserSignInEvent {
  const UserSignIn();
}

class UserSignInGoogle extends UserSignInEvent {
  const UserSignInGoogle();
}

class UserSignInSoftReset extends UserSignInEvent {
  const UserSignInSoftReset();
}
