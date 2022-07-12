part of 'event_focus_bloc.dart';

abstract class EventFocusState extends Equatable {
  const EventFocusState();

  @override
  List<Object> get props => [];
}

class EventFocused extends EventFocusState {
  final String eventTag;
  final Event event;

  const EventFocused(
    this.eventTag,
    this.event,
  ) : super();
}

class NoEventFocus extends EventFocusState {
  const NoEventFocus() : super();
}
