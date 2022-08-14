part of 'user_profile_bloc.dart';

enum UserProfileStatus {
  ready,
  error,
}

enum UserProfileNotification {
  none,
  emailVerificationSent,
  emailVerificationVerified,
  emailVerificationFailed,
  passwordEmailSent,
  passwordEmailFailedSent,
  nicknameChanged,
  nicknameNotChanged,
  pictureChanged,
  pictureNotChanged,
}

class UserProfileState extends Equatable {
  final User user;
  final UserProfileStatus status;
  final String message;
  final UserProfileNotification notification;
  final bool editingNickname;
  final String nickname;
  const UserProfileState({
    required this.user,
    this.status = UserProfileStatus.ready,
    this.message = '',
    this.notification = UserProfileNotification.none,
    this.editingNickname = false,
    required this.nickname,
  });

  @override
  List<Object> get props => [
        user,
        status,
        message,
        notification,
        editingNickname,
        nickname,
      ];

  UserProfileState copyWith({
    User? user,
    UserProfileStatus? status,
    String? message,
    UserProfileNotification? notification,
    bool? editingNickname,
    String? nickname,
  }) {
    return UserProfileState(
      user: user ?? this.user,
      status: status ?? this.status,
      message: message ?? this.message,
      notification: notification ?? this.notification,
      editingNickname: editingNickname ?? this.editingNickname,
      nickname: nickname ?? this.nickname,
    );
  }
}
