import 'dart:async';

import 'package:blavapp/model/event.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:blavapp/services/prefs_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final PrefsRepo _prefs;
  final DataRepo _dataRepo;
  StreamSubscription<Event>? _eventStream;

  EventBloc({
    required PrefsRepo prefs,
    required DataRepo dataRepo,
  })  : _prefs = prefs,
        _dataRepo = dataRepo,
        super(const EventState()) {
    // Stream listeners
    on<EventStreamChanged>(_onEventStreamChange);
    on<EventSubscriptionFailed>(_onEventSubscriptionFailed);
    // Event listeners
    on<EventLoad>(_loadState);
    on<EventSelected>(_eventSelected);
    on<EventClear>(_eventClear);
    // Init
    // add(const EventLoad());
  }

  FutureOr<void> _onEventStreamChange(
    EventStreamChanged event,
    Emitter<EventState> emit,
  ) {
    final Event eventData = event.event;
    emit(EventState(
      status: EventStatus.selected,
      eventTag: eventData.id,
      event: eventData,
      remainingToStart: DateTime.now().isBefore(eventData.dayStart)
          ? eventData.dayStart.difference(DateTime.now())
          : null,
      isOngoing: DateTime.now().isAfter(eventData.dayStart) &&
          DateTime.now().isBefore(eventData.dayEnd),
    ));
  }

  FutureOr<void> _onEventSubscriptionFailed(
    EventSubscriptionFailed event,
    Emitter<EventState> emit,
  ) {
    emit(const EventState(
      status: EventStatus.empty,
      eventTag: '',
    ));
  }

  @override
  Future<void> close() {
    _eventStream?.cancel();
    return super.close();
  }

  Future<void> _loadState(
    _,
    Emitter<EventState> emit,
  ) async {
    final String? eventID = _prefs.loadEvent();
    add(EventSelected(eventID: eventID));
  }

  Future<void> _eventClear(
    _,
    Emitter<EventState> emit,
  ) async {
    add(const EventSelected(eventID: null));
  }

  FutureOr<void> _eventSelected(
    EventSelected event,
    Emitter<EventState> emit,
  ) {
    _prefs.saveEvent(event.eventID ?? '');
    if (event.eventID == null || event.eventID == '') {
      emit(const EventState(
        status: EventStatus.empty,
        eventTag: '',
        event: null,
      ));
    } else {
      if (_eventStream != null) {
        _eventStream!.cancel();
      }
      _eventStream = _dataRepo.getEventStream(event.eventID!).listen(
            (Event event) => add(
              EventStreamChanged(
                event: event,
              ),
            ),
          )..onError(
          (error) {
            if (error is NullDataException) {
              add(EventSubscriptionFailed(message: error.message));
            } else {
              add(EventSubscriptionFailed(message: error.toString()));
            }
          },
        );
    }
  }
}
