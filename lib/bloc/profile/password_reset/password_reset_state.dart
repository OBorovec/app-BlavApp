part of 'password_reset_bloc.dart';

enum PasswordResetStatus { ready, loading, success, fail }

class PasswordResetState extends Equatable {
  final PasswordResetStatus status;
  final String message;
  final String email;
  final bool isValid;
  const PasswordResetState({
    this.status = PasswordResetStatus.ready,
    this.message = '',
    this.email = '',
    this.isValid = true,
  });

  @override
  List<Object> get props => [status, message, email, isValid];

  PasswordResetState copyWith({
    PasswordResetStatus? status,
    String? message,
    String? email,
    bool? isValid,
  }) {
    return PasswordResetState(
      status: status ?? this.status,
      message: message ?? this.message,
      email: email ?? this.email,
      isValid: isValid ?? this.isValid,
    );
  }
}
