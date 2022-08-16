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

class UserDataDegustationFavorite extends UserDataEvent {
  final String itemRef;

  const UserDataDegustationFavorite({
    required this.itemRef,
  });
}

class UserDataRateItem extends UserDataEvent {
  final String itemRef;
  final double rating;

  const UserDataRateItem({
    required this.itemRef,
    required this.rating,
  });
}

class UserDataVoteCosplay extends UserDataEvent {
  final String cosplayRef;
  final String voteRef;
  final bool? vote;

  const UserDataVoteCosplay({
    required this.cosplayRef,
    required this.voteRef,
    required this.vote,
  });
}

class UserDataFeedBack extends UserDataEvent {
  final double rating;
  final String reference;
  final String message;
  final bool signed;

  const UserDataFeedBack({
    required this.rating,
    required this.reference,
    required this.message,
    this.signed = false,
  });
}

class UserDataHelp extends UserDataEvent {
  final String title;
  final String message;

  const UserDataHelp({
    required this.title,
    required this.message,
  });
}

class UserDataHelpResponse extends UserDataEvent {
  final String id;
  final String message;

  const UserDataHelpResponse({
    required this.id,
    required this.message,
  });
}
