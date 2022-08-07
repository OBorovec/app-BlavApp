part of 'user_data_bloc.dart';

abstract class UserDataEvent extends Equatable {
  const UserDataEvent();

  @override
  List<Object> get props => [];
}

class EmptyUserData extends UserDataEvent {}

class InitUserData extends UserDataEvent {
  final User user;
  const InitUserData({required this.user});
}

class SetUserData extends UserDataEvent {
  final UserData userData;

  const SetUserData(this.userData);

  @override
  List<Object> get props => [userData];
}

abstract class UserDataProgrammeEvent extends UserDataEvent {
  final String entryId;

  const UserDataProgrammeEvent({
    required this.entryId,
  });

  @override
  List<Object> get props => [entryId];
}

class UserDataMyProgramme extends UserDataProgrammeEvent {
  const UserDataMyProgramme({required String entryId})
      : super(entryId: entryId);
}

class UserDataProgMyNotification extends UserDataProgrammeEvent {
  const UserDataProgMyNotification({required String entryId})
      : super(entryId: entryId);
}

class UserDataRateItem extends UserDataEvent {
  final String itemRef;
  final double rating;

  const UserDataRateItem({
    required this.itemRef,
    required this.rating,
  });
}
