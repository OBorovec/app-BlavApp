part of 'password_reset_bloc.dart';

abstract class PasswordResetEvent extends Equatable {
  const PasswordResetEvent();

  @override
  List<Object> get props => [];
}

class PasswordResetEmailChanged extends PasswordResetEvent {
  final String email;
  const PasswordResetEmailChanged({
    required this.email,
  });
}

class PasswordReset extends PasswordResetEvent {
  const PasswordReset();
}
