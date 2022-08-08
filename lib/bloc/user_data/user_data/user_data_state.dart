part of 'user_data_bloc.dart';

enum DataStatus { active, inactive }

class UserDataState extends Equatable {
  final DataStatus dataStatus;
  final UserData userData;
  const UserDataState({
    required this.dataStatus,
    required this.userData,
  });

  @override
  List<Object> get props => [dataStatus, userData];
}
