part of 'user_perms_bloc.dart';

class UserPermsState extends Equatable {
  final UserPerms userPrems;
  const UserPermsState({
    required this.userPrems,
  });

  @override
  List<Object> get props => [userPrems];
}
