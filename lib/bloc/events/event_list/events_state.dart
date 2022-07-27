part of 'events_bloc.dart';

abstract class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object> get props => [];
}

class EventsInitial extends EventsState {}

class EventsFailState extends EventsState {
  final String message;

  const EventsFailState(this.message);

  @override
  List<Object> get props => [message];
}

class EventsLoadedState extends EventsState {
  final List<Event> upComingEvents;
  final List<Event> pastEvents;

  const EventsLoadedState({
    required this.upComingEvents,
    required this.pastEvents,
  });

  @override
  List<Object> get props => [upComingEvents];
}
