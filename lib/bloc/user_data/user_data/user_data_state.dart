part of 'user_data_bloc.dart';

enum DataState { active, inactive }

class UserDataState extends Equatable {
  final DataState dataState;
  final UserData userData;
  const UserDataState({
    required this.dataState,
    required this.userData,
  });

  @override
  List<Object> get props => [dataState, userData];
}
