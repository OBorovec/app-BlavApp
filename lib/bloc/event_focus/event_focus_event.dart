part of 'event_focus_bloc.dart';

abstract class EventFocus extends Equatable {
  const EventFocus();

  @override
  List<Object> get props => [];
}

class EventFocusChanged extends EventFocus {
  final String? eventID;

  const EventFocusChanged({required this.eventID});

  @override
  List<Object> get props => [eventID ?? ''];
}

class EventFocusLoad extends EventFocus {
  const EventFocusLoad();

  @override
  List<Object> get props => [];
}

class EventFocusClear extends EventFocus {
  const EventFocusClear();

  @override
  List<Object> get props => [];
}
