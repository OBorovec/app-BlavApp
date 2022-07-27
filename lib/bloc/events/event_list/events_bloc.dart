import 'package:blavapp/model/event.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final DataRepo _dataRepo;
  EventsBloc({
    required DataRepo dataRepo,
  })  : _dataRepo = dataRepo,
        super(EventsInitial()) {
    on<LoadEvents>(_loadEvents);
  }

  Future<void> _loadEvents(_, emit) async {
    try {
      final List<Event> events = await _dataRepo.getEvents();
      final List<Event> upComingEvents = events.where((event) {
        return event.timestampEnd.isAfter(DateTime.now());
      }).toList();
      final List<Event> pastEvents = events.where((event) {
        return event.timestampEnd.isBefore(DateTime.now());
      }).toList();
      emit(EventsLoadedState(
        upComingEvents: upComingEvents,
        pastEvents: pastEvents,
      ));
    } on Exception catch (e) {
      emit(
        EventsFailState(e.toString()),
      );
    }
  }
}
