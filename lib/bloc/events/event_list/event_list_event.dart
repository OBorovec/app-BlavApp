part of 'event_list_bloc.dart';

abstract class EventListEvent extends Equatable {
  const EventListEvent();

  @override
  List<Object> get props => [];
}

class LoadEvents extends EventListEvent {}
