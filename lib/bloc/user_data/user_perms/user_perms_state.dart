part of 'user_perms_bloc.dart';

class UserPermsState extends Equatable {
  final UserPerms userPerms;
  final bool devMode;

  const UserPermsState({
    required this.userPerms,
    this.devMode = false,
  });

  Roles get roles => userPerms.roles;
  bool get isAdmin => userPerms.isAdmin;
  bool get isStaff => userPerms.isStaff;

  @override
  List<Object> get props => [userPerms, devMode];

  UserPermsState copyWith({
    UserPerms? userPerms,
    bool? devMode,
  }) {
    return UserPermsState(
      userPerms: userPerms ?? this.userPerms,
      devMode: devMode ?? this.devMode,
    );
  }
}
