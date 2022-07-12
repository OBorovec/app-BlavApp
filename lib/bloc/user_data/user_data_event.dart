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

class LoadUserData extends UserDataEvent {
  final String uid;

  const LoadUserData({
    required this.uid,
  });

  @override
  List<Object> get props => [uid];
}

abstract class ProgrammeUserDataEvent extends UserDataEvent {
  final String entryId;

  const ProgrammeUserDataEvent({
    required this.entryId,
  });

  @override
  List<Object> get props => [entryId];
}

class ProgEntryToggleUserData extends ProgrammeUserDataEvent {
  const ProgEntryToggleUserData({required String entryId})
      : super(entryId: entryId);
}

class ProgNotificationToggleUserData extends ProgrammeUserDataEvent {
  const ProgNotificationToggleUserData({required String entryId})
      : super(entryId: entryId);
}
