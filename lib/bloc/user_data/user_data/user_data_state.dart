part of 'user_data_bloc.dart';

enum DataStatus { active, inactive }

class UserDataState extends Equatable {
  final DataStatus dataStatus;
  final UserData userData;
  const UserDataState({
    required this.dataStatus,
    required this.userData,
  });

  List<String> get tickets => userData.tickets;
  Set<String> get myNotifications => userData.myNotifications;
  Set<String> get myProgramme => userData.myProgramme;
  Set<String> get myFavorite => userData.favoriteSamples;
  Map<String, double> get myRatings => userData.myRatings;
  Map<String, bool?> get myVoting => userData.myVoting;

  @override
  List<Object> get props => [dataStatus, userData];
}
