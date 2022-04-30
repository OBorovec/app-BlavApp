part of 'user_data_bloc.dart';

abstract class UserDataState extends Equatable {
  const UserDataState();

  @override
  List<Object> get props => [];
}

class NoUserData extends UserDataState {}

class ActiveUserData extends UserDataState {
  final UserData userData;

  const ActiveUserData({
    required this.userData,
  });

  @override
  List<Object> get props => [userData];
}
