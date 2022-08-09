part of 'user_perms_bloc.dart';

class UserPermsState extends Equatable {
  final UserPerms userPrems;

  const UserPermsState({
    required this.userPrems,
  });

  Roles get roles => userPrems.roles;
  bool get hasAdmin => userPrems.hasAdmin;

  @override
  List<Object> get props => [userPrems];
}
