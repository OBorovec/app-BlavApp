part of 'user_sign_up_bloc.dart';

abstract class UserSignUpEvent extends Equatable {
  const UserSignUpEvent();

  @override
  List<Object> get props => [];
}

class UserSignUpEmailChanged extends UserSignUpEvent {
  final String email;
  const UserSignUpEmailChanged({
    required this.email,
  });
}

class UserSignUpPswChanged extends UserSignUpEvent {
  final String password;
  const UserSignUpPswChanged({
    required this.password,
  });
}

class UserSignUpNNChanged extends UserSignUpEvent {
  final String nickName;
  const UserSignUpNNChanged({
    required this.nickName,
  });
}

class UserSignUp extends UserSignUpEvent {
  const UserSignUp();
}

class UserSignUpGoogle extends UserSignUpEvent {
  const UserSignUpGoogle();
}
