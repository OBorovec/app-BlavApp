part of 'user_delete_bloc.dart';

enum UserDeleteStatus { ready, loading, success, fail }

class UserDeleteState extends Equatable {
  final UserDeleteStatus status;
  final String message;
  final String password;
  final bool isPasswordValid;

  const UserDeleteState({
    this.status = UserDeleteStatus.ready,
    this.message = '',
    this.password = '',
    this.isPasswordValid = true,
  });

  @override
  List<Object> get props => [
        status,
        message,
        password,
        isPasswordValid,
      ];

  UserDeleteState copyWith({
    UserDeleteStatus? status,
    String? message,
    String? password,
    bool? isPasswordValid,
  }) {
    return UserDeleteState(
      status: status ?? this.status,
      message: message ?? this.message,
      password: password ?? this.password,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
    );
  }
}
