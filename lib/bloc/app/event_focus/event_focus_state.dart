part of 'event_focus_bloc.dart';

enum EventFocusStatus { focused, empty }

class EventFocusState extends Equatable {
  final EventFocusStatus status;
  final String eventTag;
  final Event? event;
  final Duration? remainingToStart;
  final bool isOngoing;

  const EventFocusState({
    required this.status,
    required this.eventTag,
    this.event,
    this.remainingToStart,
    this.isOngoing = false,
  }) : super();

  bool get isFocused => status == EventFocusStatus.focused;

  @override
  List<Object> get props => [status, eventTag, event ?? ''];
}
