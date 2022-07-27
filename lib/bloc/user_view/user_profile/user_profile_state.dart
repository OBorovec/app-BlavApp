part of 'user_profile_bloc.dart';

enum UserEditStatus {
  ready,
  emailVerificationSent,
  emailVerificationVerified,
  emailVerificationFailed,
  passwordEmailSent,
  passwordEmailFailedSent,
  nicknameChanged,
  nicknameNotChanged,
  pictureChanged,
  pictureNotChanged,
  error,
}

class UserProfileState extends Equatable {
  final User user;
  final UserEditStatus status;
  final bool editingNickname;
  final String nickname;
  final String? errorMessage;
  const UserProfileState({
    required this.user,
    this.status = UserEditStatus.ready,
    this.editingNickname = false,
    required this.nickname,
    this.errorMessage,
  });

  @override
  List<Object> get props => [
        editingNickname,
        nickname,
      ];

  UserProfileState copyWith({
    User? user,
    UserEditStatus? status,
    bool? editingNickname,
    String? nickname,
    String? errorMessage,
  }) {
    return UserProfileState(
      user: user ?? this.user,
      status: status ?? this.status,
      editingNickname: editingNickname ?? this.editingNickname,
      nickname: nickname ?? this.nickname,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
