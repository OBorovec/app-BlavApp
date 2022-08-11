part of 'user_sign_in_bloc.dart';

enum SignInStatus { ready, loading, success, fail }

class UserSignInState extends Equatable {
  final SignInStatus status;
  final String message;
  final String email;
  final bool isEmailValid;
  final String password;
  final bool isPasswordValid;
  final bool isFormValid;

  const UserSignInState({
    required this.status,
    this.message = '',
    this.email = '',
    this.isEmailValid = true,
    this.password = '',
    this.isPasswordValid = true,
    this.isFormValid = false,
  });

  @override
  List<Object> get props => [
        status,
        email,
        isEmailValid,
        password,
        isPasswordValid,
        isFormValid,
      ];

  UserSignInState copyWith({
    SignInStatus? status,
    String? message,
    String? email,
    bool? isEmailValid,
    String? password,
    bool? isPasswordValid,
    bool? isFormValid,
  }) {
    return UserSignInState(
      status: status ?? this.status,
      message: message ?? this.message,
      email: email ?? this.email,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      password: password ?? this.password,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }
}
