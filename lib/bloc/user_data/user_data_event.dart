part of 'user_data_bloc.dart';

abstract class UserDataEvent extends Equatable {
  const UserDataEvent();

  @override
  List<Object> get props => [];
}

class EmptyUserData extends UserDataEvent {}

class LoadUserData extends UserDataEvent {
  final String uid;

  const LoadUserData({
    required this.uid,
  });

  @override
  List<Object> get props => [uid];
}

abstract class ProgrammeUserDataEvent extends UserDataEvent {
  final String entryID;

  const ProgrammeUserDataEvent({
    required this.entryID,
  });

  @override
  List<Object> get props => [entryID];
}

class AddProgEntryNotification extends ProgrammeUserDataEvent {
  const AddProgEntryNotification({required String entryID})
      : super(entryID: entryID);
}

class RemoveProgEntryNotification extends ProgrammeUserDataEvent {
  const RemoveProgEntryNotification({required String entryID})
      : super(entryID: entryID);
}

class AddMyProgEntry extends ProgrammeUserDataEvent {
  const AddMyProgEntry({required String entryID}) : super(entryID: entryID);
}

class RemoveMyProgEntry extends ProgrammeUserDataEvent {
  const RemoveMyProgEntry({required String entryID}) : super(entryID: entryID);
}
