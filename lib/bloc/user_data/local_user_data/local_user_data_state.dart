part of 'local_user_data_bloc.dart';

class LocalUserDataState extends Equatable {
  final UserDataLocal userDataLocal;
  const LocalUserDataState({
    required this.userDataLocal,
  });

  Set<String> get hiddenBoardNotes => userDataLocal.hiddenBoardNotes;
  Set<String> get tastedDegustations => userDataLocal.tastedDegustations;

  @override
  List<Object> get props => [userDataLocal];

  LocalUserDataState copyWith({
    UserDataLocal? userDataLocal,
  }) {
    return LocalUserDataState(
      userDataLocal: userDataLocal ?? this.userDataLocal,
    );
  }
}
