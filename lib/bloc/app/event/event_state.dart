part of 'event_bloc.dart';

enum EventStatus { init, selected, empty }

class EventState extends Equatable {
  final EventStatus status;
  final String eventTag;
  final Event? event;
  final Duration? remainingToStart;
  final bool isOngoing;

  const EventState({
    this.status = EventStatus.init,
    this.eventTag = '',
    this.event,
    this.remainingToStart,
    this.isOngoing = false,
  }) : super();

  bool get isFocused => status == EventStatus.selected;

  @override
  List<Object> get props => [status, eventTag, event ?? ''];
}
