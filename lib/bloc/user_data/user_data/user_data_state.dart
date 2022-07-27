part of 'user_data_bloc.dart';

enum DataState { active, inactive }

class UserDataState extends Equatable {
  final DataState dataState;
  final UserData usedData;
  const UserDataState({
    required this.dataState,
    required this.usedData,
  });

  @override
  List<Object> get props => [dataState, usedData];
}
