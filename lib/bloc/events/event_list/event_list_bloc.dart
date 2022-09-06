import 'package:blavapp/model/event.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event_list_event.dart';
part 'event_list_state.dart';

class EventListBloc extends Bloc<EventListEvent, EventListState> {
  final DataRepo _dataRepo;
  EventListBloc({
    required DataRepo dataRepo,
  })  : _dataRepo = dataRepo,
        super(EventsInitial()) {
    on<LoadEvents>(_loadEvents);
    // Init
    add(LoadEvents());
  }

  Future<void> _loadEvents(_, emit) async {
    try {
      List<Event> events = await _dataRepo.getEvents();
      events = events.where((event) => event.isVisible).toList();
      final List<Event> upComingEvents = events.where((event) {
        return event.dayEnd.isAfter(DateTime.now());
      }).toList();
      final List<Event> pastEvents = events.where((event) {
        return event.dayEnd.isBefore(DateTime.now());
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
