part of 'event_focus_bloc.dart';

enum EventFocusStatus { focused, empty }

class EventFocusState extends Equatable {
  final EventFocusStatus status;
  final String eventTag;
  final Event? event;

  const EventFocusState({
    required this.status,
    required this.eventTag,
    this.event,
  }) : super();

  @override
  List<Object> get props => [status, eventTag, event ?? ''];
}
