part of 'user_sign_up_bloc.dart';

enum SignUpStatus { ready, loading, success, fail }

class UserSignUpState extends Equatable {
  final SignUpStatus status;
  final String message;
  final String email;
  final bool isEmailValid;
  final String password;
  final bool isPasswordValid;
  final String nickName;
  final bool isNickNameValid;
  final bool isFormValid;

  const UserSignUpState({
    this.status = SignUpStatus.ready,
    this.message = '',
    this.email = '',
    this.isEmailValid = true,
    this.password = '',
    this.isPasswordValid = true,
    this.nickName = '',
    this.isNickNameValid = true,
    this.isFormValid = false,
  });

  @override
  List<Object> get props {
    return [
      status,
      message ?? '',
      email,
      isEmailValid,
      password,
      isPasswordValid,
      nickName,
      isNickNameValid,
      isFormValid,
    ];
  }

  UserSignUpState copyWith({
    SignUpStatus? status,
    String? message,
    String? email,
    bool? isEmailValid,
    String? password,
    bool? isPasswordValid,
    String? nickName,
    bool? isNickNameValid,
    bool? isFormValid,
  }) {
    return UserSignUpState(
      status: status ?? this.status,
      message: message ?? this.message,
      email: email ?? this.email,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      password: password ?? this.password,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      nickName: nickName ?? this.nickName,
      isNickNameValid: isNickNameValid ?? this.isNickNameValid,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }
}
