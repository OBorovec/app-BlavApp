part of 'event_list_bloc.dart';

abstract class EventListState extends Equatable {
  const EventListState();

  @override
  List<Object> get props => [];
}

class EventsInitial extends EventListState {}

class EventsFailState extends EventListState {
  final String message;

  const EventsFailState(this.message);

  @override
  List<Object> get props => [message];
}

class EventsLoadedState extends EventListState {
  final List<Event> upComingEvents;
  final List<Event> pastEvents;

  const EventsLoadedState({
    required this.upComingEvents,
    required this.pastEvents,
  });

  @override
  List<Object> get props => [upComingEvents];
}
