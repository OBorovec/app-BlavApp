part of 'user_data_bloc.dart';

class UserDataState extends Equatable {
  final UserData usedData;
  const UserDataState({
    required this.usedData,
  });

  @override
  List<Object> get props => [usedData];
}
