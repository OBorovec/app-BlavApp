part of 'local_user_data_bloc.dart';

abstract class LocalUserDataEvent extends Equatable {
  const LocalUserDataEvent();

  @override
  List<Object> get props => [];
}

class LocalUserDataInit extends LocalUserDataEvent {
  const LocalUserDataInit();
}

class HideBoardNote extends LocalUserDataEvent {
  final String noteId;

  const HideBoardNote({
    required this.noteId,
  });

  @override
  List<Object> get props => [noteId];
}

class ResetBoardNotes extends LocalUserDataEvent {
  const ResetBoardNotes();
}

class LocalToggleDegustationSample extends LocalUserDataEvent {
  final String itemRef;

  const LocalToggleDegustationSample({
    required this.itemRef,
  });

  @override
  List<Object> get props => [itemRef];
}
