part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class EventStreamChanged extends EventEvent {
  final Event event;

  const EventStreamChanged({
    required this.event,
  });
}

class EventSubscriptionFailed extends EventEvent {
  final String message;

  const EventSubscriptionFailed({required this.message});
}

class EventSelected extends EventEvent {
  final String? eventID;

  const EventSelected({required this.eventID});

  @override
  List<Object> get props => [eventID ?? ''];
}

class EventLoad extends EventEvent {
  const EventLoad();
}

class EventClear extends EventEvent {
  const EventClear();
}

class EventSetDefault extends EventEvent {
  const EventSetDefault();
}
