part of 'user_perms_bloc.dart';

class UserPermsState extends Equatable {
  final UserPerms userPerms;

  const UserPermsState({
    required this.userPerms,
  });

  Roles get roles => userPerms.roles;
  bool get isAdmin => userPerms.isAdmin;
  bool get isStaff => userPerms.isStaff;

  @override
  List<Object> get props => [userPerms];
}
